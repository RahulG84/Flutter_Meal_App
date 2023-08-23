import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:udemy_meals_app/models/meal.dart';
import 'package:udemy_meals_app/widget/meals_item_trait.dart';

class MealItem extends StatelessWidget {
  Meal meal;
  void Function(Meal meal) onSelectedMeal;
  MealItem({Key? key, required this.meal, required this.onSelectedMeal})
      : super(key: key);

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          onSelectedMeal(meal);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const MealDetailsScreen(),
          //   ),
          // );
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 250,
                width: double.infinity,
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MealsItemTrait(
                            icon: Icons.timer,
                            label: '${meal.duration} min',
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          MealsItemTrait(
                            icon: Icons.crisis_alert_rounded,
                            label: complexityText,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          MealsItemTrait(
                            icon: Icons.money_off,
                            label: affordabilityText,
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
