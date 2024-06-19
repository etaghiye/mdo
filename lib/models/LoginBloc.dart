import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/Enums.dart';

abstract class LoginState {}

class UnRegistered extends LoginState {}

class LoggedOut extends LoginState {}

class LoggedIn extends LoginState {}

class WrongLogin extends LoginState {}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String _username = '';
  String _password = '';

  LoginBloc() : super(LoggedOut()) {
    on<LoginEvent>((event, emit) async {
      if (event == LoginEvent.register) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('registered', true);
        await prefs.setString('username', _username);
        await prefs.setString('password', _password);
        emit(LoggedOut());
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

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool registered = prefs.getBool('registered') ?? false;
    bool loggedIn = prefs.getBool('loggedIn') ?? false;

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
