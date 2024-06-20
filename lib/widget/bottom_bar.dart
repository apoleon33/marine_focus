import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentDestination>(
      builder: (context, currentDestination, child) => NavigationBar(
        onDestinationSelected: (int index) {
          currentDestination.currentDestination =
              AvailableDestinations.values[index];
        },
        selectedIndex: AvailableDestinations.values
            .indexOf(currentDestination.currentDestination),
        destinations: AvailableDestinations.values
            .map((e) => NavigationDestination(
                  icon: Icon(e.icon),
                  selectedIcon: Icon(e.selectedIcon),
                  label: e.label,
                ))
            .toList(),
      ),
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

/// Class to use the [Provider] package to change page.
///
/// See [this link](https://docs.flutter.dev/data-and-backend/state-mgmt/simple#changenotifier)
class CurrentDestination extends ChangeNotifier {
  AvailableDestinations _currentDestination = AvailableDestinations.home;

  AvailableDestinations get currentDestination => _currentDestination;

  set currentDestination(AvailableDestinations newCurrentDestination) {
    _currentDestination = newCurrentDestination;
    notifyListeners();
  }
}
