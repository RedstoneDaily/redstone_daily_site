import 'package:flutter/cupertino.dart';

enum MediaType {
  small(0),
  medium(1080),
  large(1920);

  const MediaType(this.width);

  final double width;
}

MediaType getMediaType(BuildContext context) {

  var width = MediaQuery.of(context).size.width;
  return width < MediaType.medium.width
      ? MediaType.small
      : width < MediaType.large.width
      ? MediaType.medium
      : MediaType.large;
}