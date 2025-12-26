import 'package:flutter/material.dart';
import 'package:w13_quiz/quiz/data/mock_grocery_repository.dart';
import 'package:w13_quiz/quiz/models/grocery.dart';
import 'package:w13_quiz/quiz/ui/groceries/grocery_form.dart';
import 'package:w13_quiz/quiz/ui/groceries/grocery_list.dart';
import 'package:w13_quiz/quiz/ui/groceries/grocery_search.dart';

class GroceryDetails extends StatefulWidget {
  const GroceryDetails({super.key, });


  @override
  State<GroceryDetails> createState() => _GroceryDetailsState();
}

enum GroceryTab { groceryList, grocerySearch }

class _GroceryDetailsState extends State<GroceryDetails> {
  GroceryTab _currentTab = GroceryTab.groceryList;

  void onCreate() async {
    // Navigate to the form screen using the Navigator push
    Grocery? newGrocery = await Navigator.push<Grocery>(
      context,
      MaterialPageRoute(builder: (context) => const GroceryForm()),
    );
    if (newGrocery != null) {
      setState(() {
        dummyGroceryItems.add(newGrocery);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        centerTitle: false,
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: onCreate, icon: const Icon(Icons.add))],
      ),
      body: IndexedStack(
        index: _currentTab.index,
        children: [
          GroceryList(),
          GrocerySearch()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab.index,
        selectedItemColor: Colors.red,
        onTap: (index) {
          setState(() {
            _currentTab = GroceryTab.values[index];
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Your Groceries'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Search'),
        ],
      ),
    );
  }
}
