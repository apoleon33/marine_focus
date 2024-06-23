import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marine_focus/widgets/bottle.dart';

import '../util/timer/pomodoro_timer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PomodoroTimer pomodoroTimer;
  late ButtonState buttonState;

  @override
  void initState() {
    super.initState();

    buttonState = ButtonState.start;
    // test by creating a pomodoro timer with already 10 minutes elapsed.
    pomodoroTimer = PomodoroTimer();
  }

  @override
  Widget build(BuildContext context) => Column(
        verticalDirection: VerticalDirection.down,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 26.0),
            child: Bottle(
              pomodoroTimer: pomodoroTimer,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 46.0),
            child: Center(
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    if (buttonState == ButtonState.start) pomodoroTimer.start();
                    setState(() {
                      buttonState = buttonState.toggle;
                    });
                  },
                  child: Text(buttonState.label),
                ),
              ),
            ),
          )
        ],
      );
}

enum ButtonState {
  start("START TIMER"),
  stop("STOP TIMER");

  final String label;

  const ButtonState(this.label);
}

extension ButtonStateExtension on ButtonState {
  ButtonState get toggle {
    switch (this) {
      case ButtonState.start:
        return ButtonState.stop;
      case ButtonState.stop:
        return ButtonState.start;
    }
  }
}
