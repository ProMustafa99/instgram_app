
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instgram/cubit&state/signup_page/signup_state.dart';
import 'package:instgram/moduel_add_user.dart';
import 'package:instgram/screen/content.dart';
import 'package:instgram/screen/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signup_cubit extends Cubit<siginup_State> {

  Signup_cubit(super.initialState);
  static Signup_cubit get(context)=>BlocProvider.of(context);

  void Info_user(context,{required name , required email ,  required id,required passowrd }) {

    AddUserModel info = AddUserModel(name , email,id,passowrd);
    FirebaseFirestore.instance.collection("user").doc(id).set(info.toMap()).then((value) {
      Tosta_mes(mess: 'Done Creata Account ' , color: Colors.green);
      navigateto_and_push(context, login_page());

    });
  }

  void Create_new_account(context,String name , String email ,String password) {

    emit(Loading_siginup());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).
    then((value) {

      Info_user(context,name: name, email: email,  id: value.user!.uid,passowrd: password);

      emit(Sussess_state_siginup());


    })
        .catchError((e) {

      emit(Error_state_siginup());
      print(" ********** HERE ERROR **********");
      Tosta_mes(mess: '${e}' , color: Colors.red);
      print(" ********** HERE ERROR **********");

    });

  }



}