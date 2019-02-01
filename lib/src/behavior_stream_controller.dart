import 'dart:async';

/// This [BehaviorStreamController] is like a mix between the
/// default [StreamController] from the Stream API and the Rx BehaviourSubject.
///
/// Read the Documentation from the "Rx BehaviourSubject".
///
/// It emits / include also the last value.
///
/// [T] is a subclass of
///
class BehaviorStreamController<T> {

  /// The [StreamController] that contains the stream with the states
  StreamController<T> _controller;
  /// The last added [T].
  T _lastEvent;

  /// [seedValue] is like a start value
  BehaviorStreamController({T seedValue}){
    _controller = StreamController<T>.broadcast(onListen: _onListen);

    if(seedValue != null){
      add(seedValue);
    }
  }

  Stream<T> get stream => _controller.stream;

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