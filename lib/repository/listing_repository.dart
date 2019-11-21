import 'dart:convert';

import 'package:reddit_flutter_app/dto/listing_dto.dart';
import 'package:reddit_flutter_app/models/listing.dart';
import 'package:http/http.dart' as http;

Future<List<Listing>> fetchListings(String filter, int startIndex, int limit) async {
  final baseUrl = 'https://newsapi.org/v2/top-headlines?country=ca';
  String filterUrl = '&category=' + filter;
  final response = await http.get(baseUrl + filterUrl + '&page=$startIndex&pageSize=$limit&apiKey=89890dc7b704411c935556f3d782017c');
  if (response.statusCode == 200) {
    final body = json.decode(response.body);
    var listings = new List<Listing>();
    for (Map data in body["articles"]) {
      listings.add(convertToListing(data));
    }
    return listings;
  } else {
    throw Exception('error fetching listings');
  }
}