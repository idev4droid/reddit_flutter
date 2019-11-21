import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/listing/bloc.dart';
import '../widgets/bottom_loader.dart';
import '../widgets/listings/listingWidget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  ListingBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = BlocProvider.of<ListingBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: buildListing()
    );
  }

  BlocBuilder<ListingBloc, ListingState> buildListing() {
    return BlocBuilder<ListingBloc, ListingState>(
      builder: (context, state) {
        if (state is ListingUninitialized) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ListingError) {
          return Center(
            child: Text('failed to fetch listings'),
          );
        }
        if (state is ListingLoaded) {
          if (state.listings.isEmpty) {
            return Center(
              child: Text('no listings'),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.listings.length
                  ? BottomLoader()
                  : ListingWidget(listing: state.listings[index]);
            },
            itemCount: state.hasReachedMax
                ? state.listings.length
                : state.listings.length + 1,
            controller: _scrollController,
          );
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.add(Fetch());
    }
  }
}
