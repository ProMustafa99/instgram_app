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

    //late String senderId;
    //   late String receiverId;
    //   late String Date_Time;
    //   late String Text;

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
}