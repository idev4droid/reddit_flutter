import 'package:flutter/material.dart';

import '../../screens/details_page.dart';
import '../../../models/listing.dart';

class ListingWidget extends StatelessWidget {
  final Listing listing;

  const ListingWidget({Key key, @required this.listing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Color.fromARGB(180, 40, 40, 40),
        child: FlatButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailsPage(screenArguments: new ScreenArguments(listing),)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                buildLeftWhiteText('${listing.sourceName} - ${listing.author}', 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: buildLeftWhiteText(listing.title, 26.0),
                ),
                Image.network(listing.thumbnailUrl),
                buildLeftWhiteText(listing.description, 16.0),
              ],
            ),
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
