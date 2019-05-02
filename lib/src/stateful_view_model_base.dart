import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:stateful_view_model/src/stateful_util.dart';

abstract class StatefulViewModel<T extends Cloneable<T>> {
  @protected
  final int maxHistoryCount;
  @protected
  final bool isHistoryEnabled;

  final List<StreamSubscription> _streamDisposeBag = List();
  final List<T> _stateHistory = List<T>();

  final Subject<T> _subject = BehaviorSubject();

  final T _initialState;

  T get initialState => _initialState.copy();

  Stream<T> get state => _subject.stream;

  StatefulViewModel(T initialState,
      {this.maxHistoryCount = 0, this.isHistoryEnabled = false})
      : _initialState = initialState {
    assert(initialState != null, "initialState can not be null");

    _subject.add(initialState);
    _stateHistory.add(initialState);
  }

  @protected
  void setState(Reducer<T> reducer) {
    T lastState = _getCopyOfLastState();

    T newState = reducer(lastState);

    assert(newState != null, "Returned state can not be null!");

    _addState(newState);
  }

  @protected
  T getState() {
    T lastState = _getCopyOfLastState();

    return lastState;
  }

  @protected
  void disposeSubscription(StreamSubscription subscription) {
    _streamDisposeBag.add(subscription);
  }

  @protected
  void disposeSubscriptions(Iterable<StreamSubscription> subscriptions) {
    _streamDisposeBag.addAll(subscriptions);
  }

  @mustCallSuper
  void dispose() {
    _streamDisposeBag.forEach((subscription) => subscription?.cancel());
  }

  // -----
  // Helper
  // -----

  void _addState(T newState) {
    _handleNewState(newState);
    _subject.add(newState);
  }

  T _getCopyOfLastState() {
    T copyOfLastState = _stateHistory.last.copy();

    return copyOfLastState;
  }

  void _handleNewState(T state) {
    if (isHistoryEnabled) {
      _appendToHistory(state);
    } else {
      _stateHistory.removeLast();
      _stateHistory.add(state);
    }
  }

  void _appendToHistory(T state) {
    var limitReached = _stateHistory.length >= maxHistoryCount;

    if (limitReached) {
      _stateHistory.removeAt(0);
    }
    _stateHistory.add(state);
  }
}
