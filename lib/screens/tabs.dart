import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:udemy_meals_app/data/dummy_data.dart';
import 'package:udemy_meals_app/provider/favorites_meals_provider.dart';
import 'package:udemy_meals_app/provider/filters_provider.dart';
import 'package:udemy_meals_app/provider/meals_provider.dart';
import 'package:udemy_meals_app/screens/catergories.dart';
import 'package:udemy_meals_app/screens/filters.dart';
import 'package:udemy_meals_app/screens/meals.dart';
import 'package:udemy_meals_app/widget/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int selectedIndex = 0;

  void onSetScreen(String identifiers) async {
    Navigator.pop(context);
    if (identifiers == 'filters') {
      await Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(
          builder: (context) => const FiltersScreen(),
        ),
      );
    } else {
      // Navigator.pop(context);
    }
  }

  void selectedPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );

    var activePageTitle = 'Categories';

    if (selectedIndex == 1) {
      final favoriteMeals = ref.watch(favoritesMealsProvider);
      activePage = MealsScreen(
        meal: favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectedScreen: onSetScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
        onTap: selectedPage,
        currentIndex: selectedIndex,
        selectedIconTheme: const IconThemeData(color: Colors.amberAccent),
        selectedItemColor: Colors.amberAccent,
        unselectedItemColor: Colors.white,

        // unselectedLabelStyle:const TextStyle(
        //   color: Colors.white,
        // ),
      ),
    );
  }
}
