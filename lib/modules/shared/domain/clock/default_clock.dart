import 'clock.dart';

class DefaultClock implements Clock {
  @override
  DateTime now() => DateTime.now();
}
