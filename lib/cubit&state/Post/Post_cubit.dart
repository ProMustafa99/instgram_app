
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgram/cubit&state/Post/post_status.dart';
import 'package:instgram/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class create_post_cubit extends Cubit<create_post> {

  create_post_cubit(super.initialState);

  static create_post_cubit get(context) => BlocProvider.of(context);



  void create_post(var name, var id_user , var date_post, var post , dynamic image_post , dynamic image_user) {

    emit(Loading_create_post());
    post_model info_post = post_model("${name}","${id_user}","${date_post}","${post}","${image_post}" ,"${image_user}");

    FirebaseFirestore.instance
        .collection("posts")
        .add(info_post.toMap())
        .then((value)
          {
            emit(Sussess_state_create_post());
          })
        .catchError((error)
        {
             emit(Error_state_create_post());
       });
  }

  

}