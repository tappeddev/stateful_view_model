import 'dart:async';

/// This
///
///
///
class BehaviorStreamController<T> {

  StreamController<T> _controller;
  T _lastEvent;

  BehaviorStreamController({T seedValue}){
    _controller = StreamController<T>(onListen: _onListen);

    if(seedValue != null){
      add(seedValue);
    }
  }

  Stream<T> get stream => _controller.stream.asBroadcastStream();

  set onCancel(void Function() onCancelHandler) {
    _controller.onCancel = onCancelHandler;
  }

  void add(T data) {
    _lastEvent = data;
    _controller.add(data);
  }

  void close() {
    _controller.close();
  }

  void _onListen() {
    if (_lastEvent != null) {
      _controller.add(_lastEvent);
    }
  }
}