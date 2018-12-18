import 'package:flutter_redux_demo/data/beans/bean.dart';

class Poem extends Bean {
  final String id;
  final String title;
  final String author;
  final String text;

  Poem(this.id, this.title, this.author, this.text);

  Poem.fromJson(Map<String, dynamic> json)
      : id = json['ID'].toString(),
        title = json['Title'],
        author = json['Author'],
        text = json['Text'],
        super.fromJson(json);

  Poem.copy(Poem poem)
      : id = poem.id,
        title = poem.title,
        author = poem.author,
        text = poem.text;

  @override
  String toString() {
    return 'Poem{id: $id, title: $title, author: $author, text: $text}';
  }
}
