import 'package:flutter/material.dart';
import 'package:instgram/Info_user_moduel.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgram/chat_model.dart';
import 'package:instgram/cubit&state/Chat_cubit/message_cubit.dart';
import 'package:instgram/cubit&state/Chat_cubit/message_states.dart';
import 'package:instgram/cubit&state/Home/Home_states.dart';

class ChatDetailesScreen extends StatelessWidget {

  InfoUserModel user_info;
  var TextMessage = TextEditingController();
  ChatDetailesScreen (this.user_info);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Message_cubit(LoginInitialState_message())..Get_Message(receiverId: user_info.uId),
      child: BlocConsumer<Message_cubit ,message_state>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, state) {
            return  Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row (
                  children: [

                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(user_info.image_profile),
                    ),
                    SizedBox(width: 15.0,),
                    Text(user_info.name)

                  ],
                ),
              ),
              body:ConditionalBuilder(
                condition: Message_cubit.get(context).Messages.length > 0,
                  builder: (BuildContext context) {
                   return Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: Column(
                       children: [
                         Expanded(
                           child: ListView.separated(

                               itemBuilder: (context , index)
                               {
                                 var message =Message_cubit.get(context).Messages[index];
                                  if(user_info.uId == message.receiverId)
                                    return buildMyMessage(message);

                                    return buildMessage(message);


                               },
                               separatorBuilder: (context, index) =>SizedBox(height: 15.0,),
                               itemCount:Message_cubit.get(context).Messages.length
                           ),
                         ),
                         Container(
                           decoration: BoxDecoration(
                             border: Border.all(
                               color: Colors.grey,
                             ),
                             borderRadius: BorderRadius.circular(15.0),
                           ),
                           clipBehavior: Clip.antiAliasWithSaveLayer,
                           child: Padding(
                             padding: const EdgeInsets.only(left:15),
                             child: Row(

                               children: [
                                 Expanded(
                                   child: TextFormField(
                                     decoration: InputDecoration(
                                       border: InputBorder.none,
                                       hintText: 'Type your message here...',

                                     ),
                                     controller: TextMessage,
                                   ),
                                 ),
                                 Container(
                                   height: 16.0 ,
                                   child: MaterialButton(
                                     onPressed: (){
                                       Message_cubit.get(context).sendMessgae(
                                           receiverId: user_info.uId,
                                           Date_Time: "${DateTime.now()}",
                                           Text: TextMessage.text.trim()
                                       );
                                       TextMessage.text ='';
                                     },
                                     child: const Icon(
                                       Icons.send,
                                       size: 20.0,
                                       color: Colors.blue,
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         )

                       ],
                     ),
                   );
                  },
                fallback: (BuildContext context) {
                  return Center(child: Text ("No Messages"),);
                },
              ) ,
            );
          }
      ),
    );
  }

  // Sent messages ( on the left )
  Widget buildMessage (MessageModel messageText)
  {
    return    Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            )
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Text("${messageText.Text}" ,style: TextStyle(fontSize: 15),),
      ),
    );
  }

  //my messages (on the right )
  Widget buildMyMessage (MessageModel messageText)
  {
    return     Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[500],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(0),
              bottomStart: Radius.circular(0),
              topEnd: Radius.circular(10),
            )
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Text("${messageText.Text}" ,style: TextStyle(fontSize: 15),),
      ),
    );
  }
}
