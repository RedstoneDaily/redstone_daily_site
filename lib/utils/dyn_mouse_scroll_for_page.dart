import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';

/// 解释一下这个东西是怎么来的
/// 首先Flutter的鼠标滚轮滑动不仅没法检测速度，而且还他妈的不连续 （诶有没有可能检测不了速度就是因为它不连续）
/// 所以就在网上找到了 DynMouseScroll 这个包可以让滚动连续
/// 但是 DynMouseScroll 这个包只能不能用在 PageView 中
/// 所以我就把它的短短一百多行源代码直接掏出来复制到这里然后魔改一通变成（只）能够适用于 PageView 的 DynMouseScroll
/// 也就是这个 DynMouseScrollForPage
/// 但是这段代码很屎（明明是Flutter自己的PageController自己瞎勾八私有化那么多东西害我什么都得重抄重做（甚至还得直接绕过Ballistic机制来写二阶段动画））
/// 哼哼啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊

class DynMouseScrollForPage extends StatelessWidget {
  final ScrollPhysics mobilePhysics;
  final int durationMS;
  final Function(BuildContext, PageController, ScrollPhysics) builder;

  const DynMouseScrollForPage({
    super.key,
    this.mobilePhysics = kMobilePhysics,
    this.durationMS = 50,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<_ScrollState>(
        create: (context) => _ScrollState(mobilePhysics, durationMS),
        builder: (context, _) {
          final scrollState = context.read<_ScrollState>();
          final controller = scrollState.controller;
          final physics = context.select((_ScrollState s) => s.physics);
          return Listener(
            onPointerSignal: scrollState.handleDesktopScroll,
            onPointerDown: scrollState.handleTouchScroll,
            child: builder(context, controller, physics),
          );
        });
  }
}

const kMobilePhysics = BouncingScrollPhysics();
const kDesktopPhysics = NeverScrollableScrollPhysics();

class _ScrollState with ChangeNotifier {
  final PageController controller = PageController();
  ScrollPhysics physics = kDesktopPhysics;
  double startPosition = 0;
  double futurePosition = 0;
  bool isScrolling = false;
  int eventsCount = 0;

  get offset => controller.offset;

  get position => controller.position;

  final ScrollPhysics mobilePhysics;
  final int durationMS;

  final Curve curve2 = Curves.easeOutCubic;
  final double delta = 0.05;
  late final double curve2initRate = ((curve2.transform(delta) - curve2.transform(0.0)) / delta).abs();

  _ScrollState(this.mobilePhysics, this.durationMS);

  void handleDesktopScroll(PointerSignalEvent event) {
    // Ensure desktop physics is being used.
    if (physics == kMobilePhysics) {
      physics = kDesktopPhysics;
      notifyListeners();
      return;
    }
    if (event is PointerScrollEvent) {
      // Return if limit is reached in either direction.
      if (controller.position.atEdge) {
        final dy = event.scrollDelta.dy;
        // Return if bounds exceeded.
        if (controller.position.pixels == 0) {
          if (dy < 0) return;
        } else {
          if (dy > 0) return;
        }
      }
      eventsCount++;
      int currentEvent = eventsCount;
      if (!isScrolling) {
        isScrolling = true;
        futurePosition = offset;
      }
      futurePosition += event.scrollDelta.dy;
      startPosition = offset;
      controller
          .animateTo(
        futurePosition,
        duration: Duration(milliseconds: durationMS),
        curve: Curves.linear,
      )
          .then((_) {
        if (currentEvent != eventsCount) return null;
        isScrolling = false;
        int targetPage = ((controller.page ?? 0) + 0.5 * event.scrollDelta.dy.sign).round();
        double targetPosition = getPixelsFromPage(targetPage);
        double expectedVelocity = (futurePosition - startPosition) / durationMS.toDouble();
        // expectedVelocity = distance / time * initRate
        int duration2MS = ((targetPosition - controller.offset).abs() * curve2initRate / expectedVelocity.abs()).clamp(0, 10 * durationMS).round();
        return controller.animateToPage(
          targetPage,
          duration: Duration(milliseconds: duration2MS),
          curve: curve2,
        );
      });
    }
  }

  void handleTouchScroll(PointerDownEvent event) {
    if (physics == kDesktopPhysics) {
      physics = mobilePhysics;
      notifyListeners();
    }
  }

  double getPixelsFromPage(int page) {
    return page * position.viewportDimension * controller.viewportFraction + max(0, position.viewportDimension * (controller.viewportFraction - 1) / 2);
  }
}
