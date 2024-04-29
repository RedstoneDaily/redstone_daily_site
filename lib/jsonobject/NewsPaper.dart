// To parse this JSON data, do
//
//     final newsPaper = newsPaperFromJson(jsonString);

import 'dart:convert';

NewsPaper newsPaperFromJson(String str) => NewsPaper.fromJson(json.decode(str));

String newsPaperToJson(NewsPaper data) => json.encode(data.toJson());

class NewsPaper {
  DateTime title;
  String description;
  List<Content> content;

  NewsPaper({
    required this.title,
    required this.description,
    required this.content,
  });

  factory NewsPaper.fromJson(Map<String, dynamic> json) => NewsPaper(
    title: DateTime.parse(json["title"]),
    description: json["description"],
    content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": "${title.year.toString().padLeft(4, '0')}-${title.month.toString().padLeft(2, '0')}-${title.day.toString().padLeft(2, '0')}",
    "description": description,
    "content": List<dynamic>.from(content.map((x) => x.toJson())),
  };
}

class Content {
  Type type;
  String title;
  String description;
  String url;
  String coverUrl;
  int pubdate;
  Data data;
  Author author;

  Content({
    required this.type,
    required this.title,
    required this.description,
    required this.url,
    required this.coverUrl,
    required this.pubdate,
    required this.data,
    required this.author,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    type: typeValues.map[json["type"]]!,
    title: json["title"],
    description: json["description"],
    url: json["url"],
    coverUrl: json["cover_url"],
    pubdate: json["pubdate"],
    data: Data.fromJson(json["data"]),
    author: Author.fromJson(json["author"]),
  );

  Map<String, dynamic> toJson() => {
    "type": typeValues.reverse[type],
    "title": title,
    "description": description,
    "url": url,
    "cover_url": coverUrl,
    "pubdate": pubdate,
    "data": data.toJson(),
    "author": author.toJson(),
  };
}

class Author {
  String name;
  String upic;

  Author({
    required this.name,
    required this.upic,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    name: json["name"],
    upic: json["upic"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "upic": upic,
  };
}

class Data {
  int play;
  int review;
  int like;
  int coin;
  int share;
  int favorite;
  int danmaku;
  double score;

  Data({
    required this.play,
    required this.review,
    required this.like,
    required this.coin,
    required this.share,
    required this.favorite,
    required this.danmaku,
    required this.score,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    play: json["play"],
    review: json["review"],
    like: json["like"],
    coin: json["coin"],
    share: json["share"],
    favorite: json["favorite"],
    danmaku: json["danmaku"],
    score: json["score"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "play": play,
    "review": review,
    "like": like,
    "coin": coin,
    "share": share,
    "favorite": favorite,
    "danmaku": danmaku,
    "score": score,
  };
}

enum Type {
  video
}

final typeValues = EnumValues({
  "video": Type.video
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
