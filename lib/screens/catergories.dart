import 'package:flutter/material.dart';
import 'package:udemy_meals_app/data/dummy_data.dart';
import 'package:udemy_meals_app/models/catergory.dart';
import 'package:udemy_meals_app/models/meal.dart';
import 'package:udemy_meals_app/screens/meals.dart';
import 'package:udemy_meals_app/widget/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  final List<Meal> availableMeals;
  const CategoriesScreen({
    Key? key,
    required this.availableMeals,
  }) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  // with --> This keyword is used for merge current class to the mixin class
  // late --> its helps to execute before the build method or nor to be class is created
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    // initState --> will execute before the build method will execute
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      lowerBound: 0,
      upperBound: 1,
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((element) => element.categories.contains(category.id))
        .toList();

    // final filteredMeals = dummyMeals
    //     .where((element) => element.categories.contains(category.id))
    //     .toList();
    // .where() --> its a Iterable List like Map or ListView
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meal: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: GridView(
        padding: const EdgeInsets.all(20.00),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20.00,
          mainAxisSpacing: 20.00,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onPressSelectedCategory: () {
                selectCategory(context, category);
              },
            )
        ],
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.2),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
    );
  }
}
