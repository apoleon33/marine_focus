import 'package:flutter/material.dart';
import 'package:marine_focus/util/timer/pomodoro_types.dart';
import 'package:marine_focus/widgets/bottle.dart';

import '../util/timer/pomodoro_timer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PomodoroTimer? pomodoroTimer;

  @override
  Widget build(BuildContext context) => Column(
        verticalDirection: VerticalDirection.down,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 26.0),
            child: Bottle(
              pomodoroTimer: PomodoroTimer(
                pomodoroTypes: PomodoroTypes.pomodoro,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 46.0),
            child: Center(
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {},
                  child: const Text("START TIMER"),
                ),
              ),
            ),
          )
        ],
      );
}
