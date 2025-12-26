import 'package:flutter/material.dart';
import 'package:w13_quiz/quiz/data/mock_grocery_repository.dart';
import 'package:w13_quiz/quiz/models/grocery.dart';
import 'package:w13_quiz/quiz/ui/groceries/grocery_list.dart';

class GrocerySearch extends StatefulWidget {
  const GrocerySearch({super.key});

  @override
  State<GrocerySearch> createState() => _GrocerySearchState();
}

class _GrocerySearchState extends State<GrocerySearch> {
  final TextEditingController _searchController = TextEditingController();

  List<Grocery> searchHits = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(search);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _searchController.dispose();
    super.dispose();
  }

  void search() {
    setState(() {
      String input = _searchController.text.toLowerCase();
    searchHits = dummyGroceryItems
        .where((Grocery grocery) => grocery.name.toLowerCase().contains(input))
        .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            TextField(controller: _searchController),
            Expanded(
              child: ListView.builder(
                itemCount: searchHits.length,
                itemBuilder: (context, index) {
                  final grocery = searchHits[index];
                  return GroceryTile(grocery: grocery);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
