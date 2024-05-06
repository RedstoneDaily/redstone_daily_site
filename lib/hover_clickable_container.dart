import 'package:flutter/material.dart';

void _defaultOnTap() {}

// A custom widget that makes its child clickable and highlights on hover.
class HoverClickableContainer extends StatefulWidget {
  final Widget child; // Child widget to wrap.
  final void Function() onTap;
  final Color? highlightColor; // Color to use for highlighting on hover.
  final Duration duration; // Duration of the hover animation.
  final Curve curve; // Animation curve for the hover effect.

  const HoverClickableContainer({
    super.key,
    required this.child,
    this.onTap = _defaultOnTap,
    this.highlightColor,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.ease,
  });

  @override
  HoverClickableContainerState createState() => HoverClickableContainerState();
}

class HoverClickableContainerState extends State<HoverClickableContainer> {
  bool hover = false; // Tracks if the mouse is hovering over the widget.

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true), // Sets hover state to true when mouse enters.
      onExit: (_) => setState(() => hover = false), // Sets hover state to false when mouse exits.
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          // An animated container that changes color based on hover state.
          duration: widget.duration,
          curve: widget.curve,
          decoration: BoxDecoration(
            color: hover ? (widget.highlightColor ?? Theme.of(context).hoverColor) : null, // Applies highlight color only when hovering.
          ),
          child: widget.child, // Displays the wrapped child widget.
        ),
      ),
    );
  }
}
