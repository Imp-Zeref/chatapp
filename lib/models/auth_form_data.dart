import 'dart:io';

enum AuthMode { singUp, login }

class AuthFormData {
  String name = '';
  String email = '';
  String password = '';

  File? image;

  AuthMode _mode = AuthMode.login;

  bool get isLogin {
    return _mode == AuthMode.login;
  }

  bool get isSignUp {
    return _mode == AuthMode.singUp;
  }

  void toggleAuthMode() {
    _mode = isLogin ? AuthMode.singUp : AuthMode.login;
  }
}
