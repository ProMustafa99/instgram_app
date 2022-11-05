
import 'package:flutter/material.dart';
import 'package:instgram/cah_helper/cach_helper.dart';
import 'package:instgram/cubit&state/Info_user/info_user_cubit.dart';
import 'package:instgram/cubit&state/Info_user/info_user_states.dart';
import 'package:instgram/screen/Edit_profile.dart';
import 'package:instgram/screen/content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class setting extends StatefulWidget {
  const setting({Key? key}) : super(key: key);

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {

  initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider (
      create: (BuildContext context) => Get_Info_cubit(LoginInitialState_Get_Info())..Data_user(),
      child:  BlocConsumer<Get_Info_cubit , Info_user>(
        listener: (context, state){},
        builder: (context , state) {
          return Scaffold(
            body: Column(
              children:
              [
                Container(
                  height: 270.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          width: double.infinity,
                          child: Card(
                            elevation: 10.0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child:Image(
                              image: NetworkImage("${Get_Info_cubit.get(context).Info_user.image_cover}"),
                              fit: BoxFit.cover,
                              height: 200.0,
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 60.0,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 55.0,
                          backgroundImage:NetworkImage("${Get_Info_cubit.get(context).Info_user.image_profile}"),

                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Text("${Get_Info_cubit.get(context).Info_user.name}" , style: TextStyle(fontSize: 27, fontWeight:FontWeight.bold),),
                SizedBox(height:10,),
                Container(
                  width: 200,
                  height: 100,
                  child: Expanded(
                    child:Column(
                      children: [
                        Text("${Get_Info_cubit.get(context).Info_user.bio}",style: TextStyle(color: Colors.grey),)
                      ],
                    )
                    ,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: Row(
                    children:
                    [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text("100" ,style: TextStyle(fontSize: 15, fontWeight:FontWeight.bold)),
                              SizedBox(height: 10,),
                              Text("POST " , style: TextStyle(fontSize: 15,color:Colors.grey),),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text("100" , style: TextStyle(fontWeight:FontWeight.bold),),
                              SizedBox(height: 10,),
                              Text("Followers " , style: TextStyle(fontSize: 15,color:Colors.grey),),

                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [

                              Text("100" ,style: TextStyle( fontWeight:FontWeight.bold),),
                              SizedBox(height: 10,),
                              Text("Following " , style: TextStyle(fontSize: 15,color:Colors.grey),),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text("100" ,style: TextStyle( fontWeight:FontWeight.bold),),
                              SizedBox(height: 10,),
                              Text("Photos " , style: TextStyle(fontSize: 15 ,color:Colors.grey),),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children:
                  [
                    Expanded(
                        child:OutlinedButton(
                          onPressed: () {
                            Get_Info_cubit.get(context).add_post();
                          },
                          child: Text("Add Photoes"""),)
                    ),
                    SizedBox(width: 10,),
                    OutlinedButton(
                      onPressed: (){
                        navigateto_page(context ,Edit_profile());
                      },
                      child:Icon(Icons.edit) ,
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
          );
        }
      ),
    );
  }
}