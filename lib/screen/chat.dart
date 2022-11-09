
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgram/Info_user_moduel.dart';
import 'package:instgram/cubit&state/Info_user/info_user_cubit.dart';
import 'package:instgram/cubit&state/Info_user/info_user_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:instgram/screen/chat_detailes_screens.dart';
import 'package:instgram/screen/content.dart';

class chat extends StatefulWidget {
  const chat({Key? key}) : super(key: key);

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider (
      create: (BuildContext context) => Get_Info_cubit(LoginInitialState_Get_Info())..get_all_user(),
      child:  BlocConsumer<Get_Info_cubit , Info_user>(
          listener: (context, state){},
          builder: (context , state) {
            return Scaffold(
              body: ConditionalBuilder(
                condition: Get_Info_cubit.get(context).users_list.length !=0,
                builder: (context) {
                  return ListView.separated(
                      itemBuilder: (context, index) =>chat_block(Get_Info_cubit.get(context).users_list[index] , context) ,
                      separatorBuilder: (context , index) => const Divider(),
                      itemCount: Get_Info_cubit.get(context).users_list.length
                  );
                },
                fallback: (context) => const Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child:  Text("Not Found Users"),
                  )
                ),
              ),
            );
          }
      ),
    );
  }
}



Widget chat_block (InfoUserModel info_user , context)
{
  return InkWell(
    onTap: () {
      navigateto_page (context , ChatDetailesScreen(info_user));
    },
    child: SingleChildScrollView(
        child: Column(
          children: [
            Padding (
              padding: EdgeInsets.all(30),
              child: Row(
                children:  [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage("${info_user.image_profile}"),
                  ),
                  SizedBox(width: 20,),
                  Text("${info_user.name}",style: TextStyle(fontSize: 15 ,fontWeight:FontWeight.bold),),
                ],
              ),
            ),
          ],
        )
    ),
  );
}

