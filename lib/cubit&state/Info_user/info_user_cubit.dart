
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgram/Info_user_moduel.dart';
import 'package:instgram/cah_helper/cach_helper.dart';
import 'package:instgram/cubit&state/Info_user/info_user_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instgram/post_model.dart';
import 'package:instgram/screen/content.dart';
import 'package:instgram/screen/layout.dart';


class Get_Info_cubit extends Cubit<Info_user> {

  Get_Info_cubit(super.initialState);

  static Get_Info_cubit get(context) => BlocProvider.of(context);

  InfoUserModel Info_user = InfoUserModel("","","","","","","");
  post_model post_user = post_model("","","","","","");
  
  List<InfoUserModel> users_list =[];

  var post ="";
  void Data_user() async {
    Data = Cash_Data();
    var cheeck_id = await Data.getData(key: "user_id");

    emit(Loading_Get_Info());
    FirebaseFirestore.instance.collection("user").doc("${cheeck_id}")
        .get().
        then((value)  {

          Info_user = InfoUserModel.fromJson(value.data()!);
          emit(Sussess_state_Get_Info());

        }).catchError((e){
          print("HERE ERROR ${e.toString()}");
    });

  }

  void Chang_Date_user(context,String Name , String Email , String Bio ,) async {
    emit(Loading_Change_Data());

    Data = Cash_Data();
    var cheeck_id = await Data.getData(key: "user_id");
    FirebaseFirestore.instance.collection("user").doc('${cheeck_id}').update({
      "name":Name,
      "email":Email,
      "bio":Bio,
    }).then((value)
    {
      emit(Sussess_state_Change_Data());
      Tosta_mes(mess:"Done change Data" ,color: Colors.green,);
      navigateto_and_push(context, layout());

    });

  }
  
  void get_all_user() {
    emit(Loading_Get_all_user());
    FirebaseFirestore.instance.
    collection("user").
    get().
    then((value) {
      value.docs.forEach((users) async{
         Data = Cash_Data();
          var cheeck_id = await Data.getData(key: "user_id");
          if (users.id != cheeck_id) {
            users_list.add(InfoUserModel.fromJson(users.data()));
          }
      });
        emit(Sussess_state_Get_all_user());
      print("Done Get All Users");
    }).
    catchError((error){
      print("Cant Get All Users");
      print("${error}");
      emit(Error_state_Get_all_user());
    });
  }

}