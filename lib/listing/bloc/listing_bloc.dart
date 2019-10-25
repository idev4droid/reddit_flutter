import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:reddit_flutter_app/listing/models/listing.dart';
import 'package:reddit_flutter_app/listing/models/subreddit_enum.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

import 'listing_event.dart';
import 'listing_state.dart';

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  final http.Client httpClient;
  final SubredditFilter filter;

  ListingBloc({@required this.httpClient, this.filter});

  @override
  get initialState => ListingUninitialized();

  @override
  Stream<ListingState> transformEvents(
      Stream<ListingEvent> events,
      Stream<ListingState> Function(ListingEvent event) next,
      ) {
    return super.transformEvents(
      (events as Observable<ListingEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }


  @override
  Stream<ListingState> mapEventToState(ListingEvent event) async* {
    final currentState = state;
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is ListingUninitialized) {
          final posts = await _fetchListings(0, 20);
          yield ListingLoaded(listings: posts, hasReachedMax: false);
          return;
        }
        if (currentState is ListingLoaded) {
          final listings =
          await _fetchListings(currentState.listings.length, 20);
          yield listings.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : ListingLoaded(
            listings: currentState.listings + listings,
            hasReachedMax: false,
          );
        }
      } catch (_) {
        yield PostError();
      }
    }
  }

  bool _hasReachedMax(ListingState state) =>
      state is ListingLoaded && state.hasReachedMax;

  Future<List<Listing>> _fetchListings(int startIndex, int limit) async {
    final baseUrl = 'https://www.reddit.com/r/pathofexile/';
    String filterUrl = '';
    switch (filter) {
      case SubredditFilter.Hot:
        filterUrl = "hot";
        break;
      case SubredditFilter.New:
        filterUrl = "new";
        break;
      case SubredditFilter.Top:
        filterUrl = "top";
        break;
    }

    final response = await httpClient.get(baseUrl + filterUrl + '.json?count=$startIndex&limit=$limit');
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final rawListings = body["data"]["children"];
      var listings = new List<Listing>();
      for (Map rawListing in rawListings) {
        final data = rawListing["data"];
        listings.add(
            Listing(
                id: get(data, "id", null),
                subreddit: get(data, "subreddit", null),
                title: get(data, "title", null),
                thumbnailUrl: get(data, "thumbnail", null),
                authorFullname: get(data, "author_fullname", null),
                score: get(data, "score", null),
                isVideo: get(data, "isVideo", null),
                createdTimestamp: get(data, "created", null),
                description: get(data, "selftext", null)
            )
        );
      }
      return listings;
    } else {
      throw Exception('error fetching listings');
    }
  }

  get(data, key, defaultValue) => data.containsKey(key) ? data[key] : defaultValue;



}
