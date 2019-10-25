import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'listing/bloc/bloc.dart';
import 'home_page.dart';
import 'listing/models/subreddit_enum.dart';
import 'simple_bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reddit Flutter',
        theme: ThemeData(
          primarySwatch: MaterialColor( Colors.black.value,
            <int, Color>{
              50: Color(Colors.black.value),
              100: Color(Colors.black.value),
              200: Color(Colors.black.value),
              300: Color(Colors.black.value),
              400: Color(Colors.black.value),
              500: Color(Colors.black.value),
              600: Color(Colors.black.value),
              700: Color(Colors.black.value),
              800: Color(Colors.black.value),
              900: Color(Colors.black.value),
            },
          ),
          accentColor: Colors.white
        ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "Hot"),
                Tab(text: "Top"),
                Tab(text: "New"),
              ],
            ),
            title: Text('Reddit'),
          ),
          body: TabBarView(
            children: [
              homePageProvider(SubredditFilter.Hot),
              homePageProvider(SubredditFilter.Top),
              homePageProvider(SubredditFilter.New),
            ],
          ),
        ),
      )
    );
  }

  BlocProvider<ListingBloc> homePageProvider(SubredditFilter filter) {
    return BlocProvider(
        builder: (context) =>
        ListingBloc(httpClient: http.Client(), filter: filter)..add(Fetch()),
        child: HomePage(),
      );
  }
}
