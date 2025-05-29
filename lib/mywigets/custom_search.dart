import 'package:flutter/material.dart';
import 'package:wms/modles/constant_colors.dart';

class CustomSearch extends SearchDelegate {
  List<String>? inputList = ['suggestion 1', 'suggestion 2', 'sugestion 3'];
  List<String>? filterList;
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
                title: Text(inputList![index]),
                onTap: () {
                  showResults(context);
                },
              ),
            );
          },
        ),
      );
    } else {
      filterList =
          inputList!
              .where((ele) => ele.toLowerCase().contains(query.toLowerCase()))
              .toList();
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView.builder(
          itemCount: filterList!.length,
          itemBuilder: (context, index) {
            final suggestion = filterList![index];
            final matchText = suggestion.substring(0, query.length);
            final remainingText = suggestion.substring(query.length);

            return Card(
              child: ListTile(
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: matchText,
                        style: const TextStyle(
                          color: Colors.pink, // اللون الأزرق
                          fontSize: 23, // حجم أكبر للنص المطابق
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: remainingText,
                        style: TextStyle(
                          color: Colors.grey[600], // لون لباقي النص
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
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
