import 'dart:async';
import 'dart:ui';

class EasyDebouncer {
  Timer? _timer;

  void run(Duration delay, VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}