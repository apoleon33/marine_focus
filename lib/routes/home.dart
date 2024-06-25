import 'package:flutter/material.dart';
import 'package:marine_focus/util/timer/pomodoro_states.dart';
import 'package:marine_focus/util/timer/pomodoro_types.dart';
import 'package:marine_focus/widgets/bottle.dart';

import '../util/timer/pomodoro_timer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PomodoroTimer _pomodoroTimer;
  late ButtonState buttonState;

  @override
  void initState() {
    super.initState();

    buttonState = ButtonState.start;

    pomodoroTimer = PomodoroTimer(pomodoroTypes: PomodoroTypes.shortBreak);

    pomodoroTimer.isFinishedNotifier.addListener(() {
      if (pomodoroTimer.isFinished) {
        setState(() {});
      }
    });
  }

  void _toggleButton() {
    if (buttonState == ButtonState.start) {
      pomodoroTimer.start();
    } else {
      pomodoroTimer = pomodoroTimer.pause();
    }
    setState(() {
      buttonState = buttonState.toggle;
    });
  }

  set pomodoroTimer(PomodoroTimer pomodoroTimer) {
    _pomodoroTimer = pomodoroTimer;
    // we need to re-create the isFinished listener for this new object
    _pomodoroTimer.isFinishedNotifier.addListener(() {
      if (pomodoroTimer.isFinished) {
        setState(() {});
      }
    });
  }

  PomodoroTimer get pomodoroTimer => _pomodoroTimer;

  @override
  Widget build(BuildContext context) {
    if (pomodoroTimer.isFinished) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Timer Finished'),
              content: const Text('The timer has finished running.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      });
      pomodoroTimer = PomodoroTimer(
        pomodoroTypes: PomodoroTypes.shortBreak,
        pomodoroState: PomodoroState.notStarted,
      );

      _toggleButton();
    }

    return Column(
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
                onPressed: _toggleButton,
                child: Text(buttonState.label),
              ),
            ),
          ),
        )
      ],
    );
  }
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
