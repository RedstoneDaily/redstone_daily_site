import 'package:flutter/cupertino.dart';

enum MediaType {
  small(0),     // phone
  medium(1080), // half desktop
  large(1920);  // desktop

  const MediaType(this.width);

  final double width; // min width for the type
}

MediaType getMediaType(BuildContext context) {

  var width = MediaQuery.of(context).size.width;
  return width < MediaType.medium.width
      ? MediaType.small
      : width < MediaType.large.width
      ? MediaType.medium
      : MediaType.large;
}