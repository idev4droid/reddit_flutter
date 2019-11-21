import 'package:flutter/material.dart';
import 'package:reddit_flutter_app/models/listing.dart';

class DetailsWidget extends StatelessWidget {
  final Listing listing;

  const DetailsWidget({@required this.listing});

  @override
  Widget build(BuildContext context) {
    return Text(listing.toString());
  }

}