import 'dart:developer';

import 'package:get/get.dart';
import 'dart:async';

enum TimerStatus {todo, inProgress, done }

final Map<TimerStatus, String> statusNames = {
  TimerStatus.todo: 'TODO',
  TimerStatus.inProgress: 'In-Progress',
  TimerStatus.done: 'Done',
};


class TimerController extends GetxController {
  Rx<TimerStatus> timerStatus = TimerStatus.todo.obs;
  RxInt hours = 0.obs, minutes = 0.obs, seconds = 0.obs;
  late Timer timer;

  void startTimer() {
    timerStatus.value = TimerStatus.todo;
    const oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(oneSecond, (Timer timer) {
      if (seconds < 59) {
        seconds++;
      } else {
        seconds.value = 0;
        if (minutes < 59) {
          minutes++;
        } else {
          minutes.value = 0;
          hours++;
        }
      }
    });
    timerStatus.value = TimerStatus.inProgress;
    log(formattedTime());

  }

  void pauseTimer() {
    timer.cancel();
    timerStatus.value = TimerStatus.inProgress;
  }

  void stopTimer() {
    timer.cancel();
    hours.value = 0;
    minutes.value = 0;
    seconds.value = 0;
    timerStatus.value = TimerStatus.done;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String formattedTime() {
    return '${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
  }

}
