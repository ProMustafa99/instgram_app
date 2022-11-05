


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgram/cah_helper/cach_helper.dart';
import 'package:instgram/cubit&state/dark_light_mode/mode_state.dart';
import 'package:instgram/main.dart';
import 'package:instgram/screen/content.dart';
import 'package:instgram/screen/layout.dart';

class mode_cubit extends Cubit<states_mode> {

  mode_cubit(super.initialState);


  static mode_cubit get(context) => BlocProvider.of(context);

  bool mode_dark_light = false;
  void chnage_mode () async {

    mode_dark_light = !mode_dark_light;
    emit(Loading_mode());
    print(mode_dark_light);
  }
}
