import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgram/cah_helper/cach_helper.dart';
import 'package:instgram/cubit&state/dark_light_mode/mode_cubit.dart';
import 'package:instgram/cubit&state/dark_light_mode/mode_state.dart';
import 'package:instgram/cubit&state/layout/layout_cubit.dart';
import 'package:instgram/cubit&state/layout/layout_state.dart';
import 'package:instgram/screen/Home.dart';
import 'package:instgram/screen/chat.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgram/screen/content.dart';
import 'package:instgram/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class layout extends StatefulWidget {
  const layout({Key? key}) : super(key: key);

  @override
  State<layout> createState() => _layoutState();
}

class _layoutState extends State<layout> {
  int currentIndex =0;
  List<Widget> body =[
    Home(),
    chat()
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider
      (
      create: (context) =>layout_cubit(LoginInitialState()),
      child:BlocConsumer<layout_cubit ,states_layout>
        (
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: Text("Soical App "),
              actions: [
                BlocProvider (
                  create: (BuildContext context) => mode_cubit(LoginInitialState_mode()),
                  child: BlocConsumer<mode_cubit,states_mode> (
                  listener: (context, state){},
                  builder:  (context, state) {
                   return  IconButton (
                   onPressed: (){
                    mode_cubit.get(context).chnage_mode();
                   },
                    icon: Icon(
                      mode_cubit.get(context).mode_dark_light?Icons.wb_sunny_rounded:Icons.monetization_on_sharp,
                          color: HexColor("#f25e30"),
                          size:30,
                      ),
                );
                }
              )
             ),

              ],
            ),
            body: layout_cubit(LoginInitialState()).get(context).screen[layout_cubit(LoginInitialState()).get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex:layout_cubit(LoginInitialState()).get(context).currentIndex ,
                onTap: (index){
                  layout_cubit(LoginInitialState()).get(context).changBottomNavigationBar(index);
                },
                type: BottomNavigationBarType.fixed,
                items:  layout_cubit(LoginInitialState()).get(context).bottomItems
            ),
          );
        },
      ),
    );
  }
}
