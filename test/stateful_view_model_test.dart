import 'package:test/test.dart';

import '../example/stateful_view_model_example.dart';

void main() {
  setUp(() {});

  test("ds", () {
    LoginState state1 = LoginState(
        email: "dsds", password: "ssd", isLoading: false, loginButtonEnabled: true);

    LoginState state2 = LoginState(
        email: "dsds", password: "ssd", isLoading: false, loginButtonEnabled: true);


    expect(state1, state2);

  });
}
