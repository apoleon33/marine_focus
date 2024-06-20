import 'package:flutter/material.dart';
import 'package:marine_focus/widgets/bottom_bar.dart';
import 'package:marine_focus/widgets/top_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marine focus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(0, 100, 148, 1.0),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (context) => CurrentDestination(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: Consumer<CurrentDestination>(
        builder: (context, currentDestination, child) => currentDestination.currentDestination.route
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
