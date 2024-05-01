import 'package:flutter_bloc/flutter_bloc.dart';

part 'theming_state.dart';

class ThemingCubit extends Cubit<ThemingState> {
  ThemingCubit() : super(ThemingInitial());
  bool _isDark = false;
  bool get isDark => _isDark;
  void changeToDark() {
    _isDark = true;
    emit(ThemeChanged());
  }

  void changeToLight() {
    _isDark = false;
    emit(ThemeChanged());
  }
}
