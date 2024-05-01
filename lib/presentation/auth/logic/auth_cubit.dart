import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { authenticated, unauthenticated, unknown }

class AuthCubit extends Cubit<AuthStatus> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SharedPreferences _prefs;

  AuthCubit(this._prefs) : super(AuthStatus.unknown) {
    initializeAuth();
  }

  Future<void> initializeAuth() async {
    final bool isAuthenticated = _prefs.getBool('authenticated') ?? false;
    if (isAuthenticated) {
      emit(AuthStatus.authenticated);
    } else {
      emit(AuthStatus.unauthenticated);
    }

    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        await _prefs.setBool(
            'authenticated', true); // Save authentication state
        emit(AuthStatus.authenticated);
      } else {
        await _prefs.setBool(
            'authenticated', false); // Save authentication state
        emit(AuthStatus.unauthenticated);
      }
    });
  }
}
