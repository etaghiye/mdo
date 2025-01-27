import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/Enums.dart';

abstract class LoginState {}

class Loading extends LoginState {}

class UnRegistered extends LoginState {}

class LoggedOut extends LoginState {}

class LoggedIn extends LoginState {}

class WrongLogin extends LoginState {}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String _username = '';
  String _password = '';

  LoginBloc() : super(Loading()) {
    on<LoginEvent>((event, emit) async {
      if (event == LoginEvent.register) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('registered', true);
        await prefs.setString('username', _username);
        await prefs.setString('password', _password);
        emit(LoggedOut());
      }
      //
      else if (event == LoginEvent.unregister) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('username');
        prefs.remove('password');
        prefs.remove('registered');
        prefs.remove('loggedIn');
        emit(UnRegistered());
      }
      //
      else if (event == LoginEvent.logIn) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var username = prefs.getString('username');
        var password = prefs.getString('password');

        if (username == _username && password == _password) {
          await prefs.setBool('loggedIn', true);
          emit(LoggedIn());
        }
        //
        else {
          emit(WrongLogin());
        }
      }
    });
    _checkLoginStatus();
  }

  void setUsername(String username) {
    _username = username;
  }

  void setPassword(String password) {
    _password = password;
  }

  String get username => _username;
  String get password => _password;

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool registered = prefs.getBool('registered') ?? false;
    bool loggedIn = prefs.getBool('loggedIn') ?? false;

    _username = prefs.getString('username') ?? '';
    _password = prefs.getString('password') ?? '';

    if (!registered) {
      emit(UnRegistered());
    }
    //
    else if (loggedIn) {
      emit(LoggedIn());
    }
    //
    else {
      emit(LoggedOut());
    }
  }
}
