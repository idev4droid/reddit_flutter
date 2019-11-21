import 'package:flutter/material.dart';
import 'package:reddit_flutter_app/models/listing.dart';

import '../widgets/details/detailsWidget.dart';

class ScreenArguments {
  final Listing listing;

  ScreenArguments(this.listing);
}

class DetailsPage extends StatefulWidget {
  final ScreenArguments screenArguments;

  const DetailsPage({@required this.screenArguments});

  @override
  _DetailsPageState createState() => _DetailsPageState(screenArguments: screenArguments);
}

class _DetailsPageState extends State<DetailsPage> {
  final ScreenArguments screenArguments;

  _DetailsPageState({@required this.screenArguments});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: DetailsWidget(listing: screenArguments.listing)
    );
  }
}