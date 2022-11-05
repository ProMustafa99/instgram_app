
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgram/cah_helper/cach_helper.dart';
import 'package:instgram/cubit&state/Home/Home_states.dart';
import 'package:instgram/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instgram/screen/content.dart';
class get_post extends Cubit<post_states> {

  get_post(super.initialState);
  static get_post get(context) => BlocProvider.of(context);

  List<post_model> posts_info = [];
  List<String> posts_id = [];
  List <int> likes =[];
  
  void Get_post () {
      emit(Loading_post());
    FirebaseFirestore.instance.collection("posts").
    get().
    then((value) {
      value.docs.forEach((post) {
          post.reference.
          collection("likes").
          get().
          then((value) {
            likes.add(value.docs.length);
            posts_id.add(post.id);
            posts_info.add(post_model.fromJson(post.data()));
            emit(Sussess_state_post());
          }).
          catchError((Error){});
      });
      emit(Sussess_state_post());
    }).
    catchError((error){
      emit(Error_state_post());
    });

  }

  void like_post (var id_post) async {

    emit(Loading_post_likes());

    Data = Cash_Data();
    var cheeck_id = await Data.getData(key: "user_id");
    FirebaseFirestore.instance.
    collection("posts").
    doc("${id_post}").
    collection("likes").
    doc("${cheeck_id}").
    set({
      "like" :true,
    }).
    then((value){
      emit(Sussess_state_post_likes());
    }).
    catchError((error){
      emit(Error_state_post_likes());
    });
  }


}