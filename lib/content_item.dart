import 'package:flutter/material.dart';

class ContentItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  final TextStyle titleStyle = const TextStyle(
    fontFamily: 'HuXiaoBo',
    fontSize: 12,
    color: Colors.white,
  );

  final TextStyle descriptionStyle = const TextStyle(
    fontFamily: 'HuXiaoBo',
    fontSize: 9,
    color: Colors.black,
  );

  const ContentItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(imageUrl),
      title: Text(
        title,
        style: titleStyle,
      ),
      subtitle: Text(
        description,
        style: descriptionStyle,
      ),
    );
  }
}
