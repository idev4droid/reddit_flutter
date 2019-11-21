import 'package:reddit_flutter_app/models/listing.dart';

import 'base_dto.dart';

Listing convertToListing(Map data) {
  return Listing(
      sourceName: get(data["source"], "name"),
      author: get(data, "author"),
      title: get(data, "title"),
      description: get(data, "description"),
      url: get(data, "url"),
      thumbnailUrl: get(data, "urlToImage"),
      publishedAt: get(data, "publishedAt"),
      content: get(data, "content")
  );
}