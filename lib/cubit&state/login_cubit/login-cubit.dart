import 'package:flutter/material.dart';
import 'package:instgram/cah_helper/cach_helper.dart';
import 'package:instgram/cubit&state/login_cubit/login-state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instgram/screen/content.dart';
import 'package:instgram/screen/layout.dart';

class login_cubit extends Cubit<login_State> {

  login_cubit(super.initialState);
  static login_cubit get(context)=>BlocProvider.of(context);

  void login (context , String email , String pass)
    {
        emit(Loading());

        FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass).
        then((value) {

          Cash_Data().Save_Data(key: "user_id", value:value.user!.uid);
          navigateto_and_push(context,layout());
          emit(Sussess_state());

        }).catchError((e) {
          emit(Error_state());

          if(e.toString() =="[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
              Tosta_mes(mess: 'This email was not found' ,color:Colors.red);
            }
          else {
            Tosta_mes(mess: 'There is an error in the password or in the email' ,color:Colors.red);
          }
        });

    }

}