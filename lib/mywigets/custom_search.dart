import 'package:flutter/material.dart';
import 'package:wms/modles/constant_colors.dart';

class CustomSearch extends SearchDelegate {
  List? inputList = ['suggestion 1', 'suggestion 2', 'sugestion 3'];
  List? filterList;
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: ConstantColors.underLineBorderAppBarCustomSearch,
      ),
      appBarTheme: Theme.of(context).appBarTheme,
      inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ConstantColors.underLineBorderAppBarCustomSearch,
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ConstantColors.underLineBorderAppBarCustomSearch,
            width: 2,
          ),
        ),
      ),
    );
  }

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
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: const Text('Result'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView.builder(
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
        ),
      );
    } else {
      filterList = inputList!.where((ele) => ele.contains(query)).toList();
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView.builder(
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
        ),
      );
    }
  }
}
