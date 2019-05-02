import 'dart:async';

import 'package:test/test.dart';

import 'test_view_model.dart';

void main() {
  // -----
  // Setup
  // -----

  TestViewModel viewModel;

  setUp(() {
    viewModel = TestViewModel();
  });

  // -----
  // Helper
  // -----

  Stream<T> _mapState<T>(T Function(TestState) mapper) =>
      viewModel.state.map(mapper);

  // ignore: invalid_use_of_protected_member
  TestState getState() => viewModel.getState();

  // -----
  // Tests
  // -----

  test("listen on state stream always emits latest state", () {
    expect(_mapState((state) => state.count), emits(0));
    expect(_mapState((state) => state.count), emits(0));

    viewModel.changeTitle("this is a test");
    expect(_mapState((state) => state.title), emits("this is a test"));
    expect(_mapState((state) => state.title), emits("this is a test"));
  });

  test("state is always a new state", () {
    final state = getState();
    final state2 = getState();

    expect(state != state2, true);
    expect(state.count == 0 && state.count == 0, true);

    viewModel.changeTitle("title");

    final state3 = getState();
    final state4 = getState();

    expect(state3 != state4, true);
    expect(state3.title == "title" && state4.title == "title", true);
  });
}
