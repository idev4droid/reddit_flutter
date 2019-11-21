import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:reddit_flutter_app/models/listing.dart';
import 'package:reddit_flutter_app/models/category_filter_enum.dart';
import 'package:reddit_flutter_app/repository/listing_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

import 'listing_event.dart';
import 'listing_state.dart';

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  final http.Client httpClient;
  final String filter;

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
          final posts = await fetchListings(filter, 0, 20);
          yield ListingLoaded(listings: posts, hasReachedMax: false);
          return;
        }
        if (currentState is ListingLoaded) {
          final listings =
          await fetchListings(filter, currentState.listings.length, 20);
          yield listings.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : ListingLoaded(
            listings: currentState.listings + listings,
            hasReachedMax: false,
          );
        }
      } catch (_) {
        yield ListingError();
      }
    }
  }

  bool _hasReachedMax(ListingState state) =>
      state is ListingLoaded && state.hasReachedMax;
}
