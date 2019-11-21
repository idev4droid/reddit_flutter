import 'package:equatable/equatable.dart';

class Listing extends Equatable {
  final String sourceName;
  final String author;
  final String title;
  final String description;
  final String url;
  final String thumbnailUrl;
  final String publishedAt;
  final String content;

  const Listing({this.sourceName, this.author, this.title, this.description, this.url, this.thumbnailUrl, this.publishedAt, this.content});

  @override
  List<Object> get props => [sourceName, author, title, description, url, thumbnailUrl, publishedAt, content];

  @override
  String toString() => 'Listing { title: $title }';
}
