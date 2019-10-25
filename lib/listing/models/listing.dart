import 'package:equatable/equatable.dart';

class Listing extends Equatable {
  final String id;
  final String subreddit;
  final String title;
  final String thumbnailUrl;
  final String authorFullname;
  final double createdTimestamp;
  final bool isVideo;
  final int score;
  final String description;

  const Listing({this.id, this.subreddit, this.title, this.thumbnailUrl, this.authorFullname, this.createdTimestamp, this.isVideo, this.score, this.description});

  @override
  List<Object> get props => [subreddit, title, thumbnailUrl];

  @override
  String toString() => 'Listing { title: $title }';
}
