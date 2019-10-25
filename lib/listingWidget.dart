import 'package:flutter/material.dart';

import 'listing/models/listing.dart';

class ListingWidget extends StatelessWidget {
  final Listing post;

  const ListingWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Color.fromARGB(165, 75, 75, 75),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              buildLeftWhiteText('${post.subreddit} - ${post.authorFullname}', 10.0),
              buildLeftWhiteText(post.title, 26.0),
              Image.network(post.thumbnailUrl),
              buildLeftWhiteText(post.description, 16.0),
              buildLeftWhiteText(post.score.toString(), 16.0)
            ],
          ),
        ),
      ),
    );
  }

  Align buildLeftWhiteText(String text, double fontSize) {
    return Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: TextStyle(fontSize: fontSize, color: Colors.white),
              ),
            );
  }


}
