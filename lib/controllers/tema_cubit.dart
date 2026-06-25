import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/tema_estado.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
    : super(ThemeState(ThemeData(scaffoldBackgroundColor: Color(0xFF6A1F1B))));

  void toggleTheme() {
    if (state.themeData.brightness == Brightness.light) {
      emit(
        ThemeState(
          ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
        ),
      );
    } else {
      emit(ThemeState(ThemeData(scaffoldBackgroundColor: Color(0xFF6A1F1B))));
    }
  }
}
