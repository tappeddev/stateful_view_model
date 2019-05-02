import 'package:stateful_view_model/stateful_view_model.dart';

class TestState implements Cloneable<TestState> {
  String title;
  int count;

  TestState(this.title, this.count);

  @override
  TestState copy() => TestState(title, count);

  factory TestState.initial() => TestState("Press a button.", 0);
}

class TestViewModel extends StatefulViewModel<TestState> {
  TestViewModel({TestState initialState})
      : super(initialState ?? TestState.initial());

  void increment() => setState((state) => state..count = state.count + 1);

  void decrement() => setState((state) => state..count = state.count - 1);

  void changeTitle(String newTitle) =>
      setState((state) => state..title = newTitle);
}
