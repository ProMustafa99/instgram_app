import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgram/cah_helper/cach_helper.dart';
import 'package:instgram/chat_model.dart';
import 'package:instgram/cubit&state/Chat_cubit/message_states.dart';
import 'package:instgram/screen/content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Message_cubit extends Cubit<message_state> {

  Message_cubit(super.initialState);
  static Message_cubit get(context) => BlocProvider.of(context);

  void sendMessgae({required receiverId , required Date_Time , required Text}) async {


    Data = Cash_Data();
    var cheeck_id = await Data.getData(key: "user_id");
    MessageModel message = MessageModel(
        "$cheeck_id",
        "$receiverId",
        "$Date_Time",
        "$Text"
    );

    //set my chat
    FirebaseFirestore.instance.
    collection("user").
    doc("$cheeck_id").
    collection("chats").
    doc("$receiverId").
    collection("messages").
    add(message.toMap()).
    then((value) {
      emit(Sussess_state_get_message());
    }).
    catchError((error){
      emit(Error_state_get_message());
    });

    // set receiver Chat
    FirebaseFirestore.instance.
    collection("user").
    doc("$receiverId").
    collection("chats").
    doc("$cheeck_id").
    collection("messages").
    add(message.toMap()).
    then((value) {
      emit(Sussess_state_get_message());
    }).
    catchError((error){
      emit(Error_state_get_message());
    });
  }

  List <MessageModel> Messages = [];
  void Get_Message( {required receiverId}) async {
    Data = Cash_Data();
    var cheeck_id = await Data.getData(key: "user_id");

    // FirebaseFirestore.instance.
    // collection("user").
    // doc("$cheeck_id").
    // collection("chats").
    // snapshots().
    // listen((event)
    // {
    //   event.docs.forEach((element) {
    //     Messages.add(MessageModel.fromJson(element.data()));
    //     print("Done Get All Message");
    //   });
    //
    //   emit(Sussess_state_get_all_message());
    // });
    
    FirebaseFirestore.instance.
    collection("user").
    doc("$cheeck_id").
    collection("chats").
    doc("$receiverId").
    collection("messages").
    orderBy('Date_Time').
    snapshots().listen((event) {
      Messages =[];
      event.docs.forEach((element) {
        Messages.add(MessageModel.fromJson(element.data()));
        print("Done Get All Message");
        emit(Sussess_state_get_all_message());
      });

    });
    

  }
}