import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: AvailablesDestination.values
          .map((e) => NavigationDestinationFormatter(availablesDestination: e))
          .toList(),
    );
  }
}

class NavigationDestinationFormatter extends StatelessWidget {
  final AvailablesDestination availablesDestination;

  const NavigationDestinationFormatter({
    super.key,
    required this.availablesDestination,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: Icon(availablesDestination.icon),
      selectedIcon: Icon(availablesDestination.selectedIcon),
      label: availablesDestination.label,
    );
  }
}

enum AvailablesDestination {
  HOME(Icons.home_outlined, Icons.home, "Home"),
  AQUARIUM(Icons.set_meal_outlined, Icons.set_meal, "Aquarium"),
  STORE(Icons.store_outlined, Icons.store, "Store");

  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const AvailablesDestination(this.icon, this.selectedIcon, this.label);
}
