import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/listing/bloc.dart';
import 'ui/screens/home_page.dart';
import 'models/category_filter_enum.dart';
import 'bloc/simple_bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Flutter',
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
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            bottom: PreferredSize(
              child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.white.withOpacity(0.3),
                tabs: [
                  Tab(text: "Business"),
                  Tab(text: "Entertainment"),
                  Tab(text: "General"),
                  Tab(text: "Health"),
                  Tab(text: "Science"),
                  Tab(text: "Sports"),
                  Tab(text: "Technology"),
                ],
              ),
              preferredSize: Size.fromHeight(30.0)
            ),
            title: Text('News'),
          ),
          body: TabBarView(
            children: [
              homePageProvider(CategoryFilter.business),
              homePageProvider(CategoryFilter.entertainment),
              homePageProvider(CategoryFilter.general),
              homePageProvider(CategoryFilter.health),
              homePageProvider(CategoryFilter.science),
              homePageProvider(CategoryFilter.sports),
              homePageProvider(CategoryFilter.technology),
            ],
          ),
        ),
      )
    );
  }

  BlocProvider<ListingBloc> homePageProvider(String filter) {
    return BlocProvider(
        builder: (context) =>
        ListingBloc(httpClient: http.Client(), filter: filter)..add(Fetch()),
        child: HomePage(),
      );
  }
}
