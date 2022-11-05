import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgram/cubit&state/layout/layout_state.dart';
import 'package:instgram/screen/Add_Post.dart';
import 'package:instgram/screen/Home.dart';
import 'package:instgram/screen/chat.dart';
import 'package:instgram/screen/setting.dart';
import 'package:instgram/screen/users.dart';

class layout_cubit extends Cubit<states_layout>
{
  layout_cubit(super.initialState);
  layout_cubit get(context)=>BlocProvider.of(context);
  int currentIndex =0;

  List<BottomNavigationBarItem> bottomItems =[
    BottomNavigationBarItem
      (
      icon: Icon(Icons.home),
      label:'Home',
    ),
    BottomNavigationBarItem
      (
      icon: Icon(Icons.wechat_sharp),
      label:'chats',
    ),
    BottomNavigationBarItem
      (
      icon: Icon(Icons.add_circle_outlined ,size: 50,),
      label:'Add Post',
    ),

    BottomNavigationBarItem
      (
      icon: Icon(Icons.account_circle_outlined),
      label:'user',
    ),

    BottomNavigationBarItem
      (
      icon: Icon(Icons.settings),
      label:'setting',
    ),

  ];

  List<Widget> screen=[
    Home(),
    chat(),
    add_post(),
    users(),
    setting(),
  ];

  void changBottomNavigationBar(int index){
    currentIndex = index;
    if(index==1){Home();}

    if(index==2){chat();}

    if(index==3){ add_post();}

    if(index==4){users();}

    if(index==5){setting();}

    emit(Sussess_state());
  }

}