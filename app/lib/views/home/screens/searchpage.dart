import 'package:app/common/widgets/custom_GNav.dart';
import 'package:app/views/home/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = '/searchpage-screen';
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void movetoHome() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(onPressed: () => movetoHome()),
        elevation: 0,
        title: Text(
          'Search',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  /** 
           *  All mechanics of search bar
           * the close button
           * back button
           * and sugestions while searching
          */
                  delegate: CustomSearchDelegate());
            },
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          )
        ],
      ),

      // This is the bottom navigation bar
      bottomNavigationBar: const CustomGNavBar(),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'Books',
    'Notes',
    'Furniture',
    'Electronics',
    'Rooms',
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var jobs in searchTerms) {
      if (jobs.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(jobs);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var jobs in searchTerms) {
      if (jobs.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(jobs);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
