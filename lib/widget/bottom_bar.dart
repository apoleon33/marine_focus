import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: AvailableDestinations.values
          .map((e) => NavigationDestination(
                icon: Icon(e.icon),
                selectedIcon: Icon(e.selectedIcon),
                label: e.label,
              ))
          .toList(),
    );
  }
}

enum AvailableDestinations {
  home(Icons.home_outlined, Icons.home, "Home"),
  aquarium(Icons.set_meal_outlined, Icons.set_meal, "Aquarium"),
  store(Icons.store_outlined, Icons.store, "Store");

  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const AvailableDestinations(this.icon, this.selectedIcon, this.label);
}
