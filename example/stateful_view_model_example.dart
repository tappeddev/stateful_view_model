import 'dart:async';

import 'package:stateful_view_model/stateful_view_model.dart';

import 'package:meta/meta.dart';

abstract class UserService {
  Stream<bool> login(String email, String password);
}

///
/// The [State] represents the [View].
/// The [State] need's to implement the [BaseState] interface!
///
class LoginState extends BaseState<LoginState> {
  String email;
  String password;
  bool loginButtonEnabled;
  bool isLoading;

  LoginState(
      {@required this.email,
      @required this.password,
      @required this.loginButtonEnabled,
      @required this.isLoading})
      : super([email, password, loginButtonEnabled, isLoading]);

  @override
  LoginState copy() => LoginState(
      email: email,
      password: password,
      loginButtonEnabled: loginButtonEnabled,
      isLoading: isLoading);
}

class LoginViewModelImpl extends StatefulViewModel<LoginState> {
  final UserService _userService;

  LoginViewModelImpl(this._userService, LoginState initialState)
      : super(initialState);

  void setMail(String emailInput) {
    LoginState state = getState();
    _updateInput(emailInput, state.password);
  }

  void setPassword(String passwordInput) {
    LoginState state = getState();
    _updateInput(state.email, passwordInput);
  }

  void login() {
    LoginState state = getState();

    disposeSubscription(
        _userService.login(state.email, state.password).listen((success) {
      //Successfully logged in
    }));
  }

  // -----
  // Helper
  // -----

  void _updateInput(String email, String password) {
    setState((state) {
      state.email = email;
      state.password = password;
      state.loginButtonEnabled = email.isEmpty && password.isEmpty;
      return state;
    });
  }
}
