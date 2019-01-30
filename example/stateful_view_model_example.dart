import 'package:stateful_view_model/stateful_view_model.dart';

import 'package:meta/meta.dart';


abstract class UserService {
  Stream<bool> login(String email, String password);
}


class LoginState implements Cloneable<LoginState> {

  String email;
  String password;
  bool loginButtonEnabled;
  bool isLoading;

  LoginState(
      {@required this.email,
        @required this.password,
        @required this.loginButtonEnabled,
        @required this.isLoading});


  @override
  LoginState copy() => LoginState(
      email: email,
      password: password,
      loginButtonEnabled: loginButtonEnabled,
      isLoading: isLoading);
}

abstract class LoginViewModel extends StatefulViewModel<LoginState> {
  LoginViewModel(LoginState initialState) : super(initialState);

  void setMail(String emailInput);

  void setPassword(String passwordInput);

  void login();
}

class LoginViewModelImpl extends LoginViewModel {
  final UserService _userService;

  LoginViewModelImpl(this._userService, LoginState initialState)
      : super(initialState);

  @override
  void setMail(String emailInput) {
    LoginState state = getState();
    _updateInput(emailInput, state.password);
  }

  @override
  void setPassword(String passwordInput) {
    LoginState state = getState();
    _updateInput(state.email, passwordInput);
  }

  void _updateInput(String email, String password) {

    setState((state) {
      state.email = email;
      state.password = password;
      state.loginButtonEnabled = email.isEmpty && password.isEmpty;
      return state;
    });
  }

  @override
  void login() {
    LoginState state = getState();

    disposeSubscription(_userService.login(state.email, state.password).listen((success)
    {
      //Successfully logged in
    }));
  }
}