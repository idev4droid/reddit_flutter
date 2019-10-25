import 'package:equatable/equatable.dart';

import '../models/listing.dart';

abstract class ListingState extends Equatable {
  const ListingState();

  @override
  List<Object> get props => [];
}

class ListingUninitialized extends ListingState {}

class PostError extends ListingState {}

class ListingLoaded extends ListingState {
  final List<Listing> listings;
  final bool hasReachedMax;

  const ListingLoaded({
    this.listings,
    this.hasReachedMax,
  });

  ListingLoaded copyWith({
    List<Listing> posts,
    bool hasReachedMax,
  }) {
    return ListingLoaded(
      listings: posts ?? this.listings,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [listings, hasReachedMax];

  @override
  String toString() =>
      'ListingLoaded { posts: ${listings.length}, hasReachedMax: $hasReachedMax }';
}