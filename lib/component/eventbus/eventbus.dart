import 'dart:async';

class EventBus {
  static final EventBus _instance = EventBus._internal();

  factory EventBus() => _instance;

  EventBus._internal();

  final _eventController = StreamController<dynamic>.broadcast();

  void fire(dynamic event) {
    _eventController.add(event);
  }

  StreamSubscription on<T>(void Function(T event) onData) {
    return _eventController.stream
        .where((event) => event is T)
        .cast<T>()
        .listen(onData);
  }

  void dispose() {
    _eventController.close();
  }
}
