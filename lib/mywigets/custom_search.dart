import 'package:flutter/material.dart';

class CustomSearch extends SearchDelegate {
  List? inputList = ['suggestion 1', 'suggestion2', 'sugestion 3'];
  List? filterList;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Result');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return ListView.builder(
        itemCount: inputList!.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('${inputList![index]}'),
              onTap: () {
                showResults(context);
              },
            ),
          );
        },
      );
    } else {
      filterList = inputList!.where((ele) => ele.contains(query)).toList();
      return ListView.builder(
        itemCount: filterList!.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('${filterList![index]}'),
              onTap: () {
                showResults(context);
              },
            ),
          );
        },
      );
    }
  }
}
