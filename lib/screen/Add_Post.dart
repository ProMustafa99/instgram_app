import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgram/cah_helper/cach_helper.dart';
import 'package:instgram/cubit&state/Info_user/info_user_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instgram/cubit&state/Post/Post_cubit.dart';
import 'package:instgram/cubit&state/Post/post_status.dart';
import 'package:instgram/post_model.dart';
import 'package:instgram/screen/content.dart';
import '../cubit&state/Info_user/info_user_cubit.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class add_post extends StatefulWidget {
  const add_post({Key? key}) : super(key: key);

  @override
  State<add_post> createState() => _add_postState();
}

var post = TextEditingController();

dynamic image_post;
dynamic name_image ;
var picker = ImagePicker();

Widget New_post() {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        child: TextFormField(
          controller: post,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.edit),
            border: InputBorder.none,
            hintText: 'What is on your mind...',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is empty';
            }
          },
        ),
      ),
    ),
  );
}

class _add_postState extends State<add_post> {

  Future getImage_post() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if(pickedFile!=null)  {
      setState(()  {
        image_post = File(pickedFile.path);
        firebase_storage.FirebaseStorage.instance.ref().
        child('post_image/${Uri.file(image_post.path).pathSegments.last}').
        putFile(image_post).
        then((value)
        {
          value.ref.getDownloadURL().
          then((value) async {
            name_image = value;
            print("Name image here ${name_image}");
          }).catchError((e){});
        }).

        catchError((e)
        {
          Tosta_mes(mess: '${e.toString()}', color: Colors.red);
        });

      });

    }
    else{
      print("No Image selectd");
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              BlocProvider(
                  create: (BuildContext context) => Get_Info_cubit(LoginInitialState_Get_Info())..Data_user(),
                  child: BlocConsumer<Get_Info_cubit, Info_user>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Row(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              backgroundImage: NetworkImage(
                                  "${Get_Info_cubit.get(context).Info_user.image_profile}"),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${Get_Info_cubit.get(context).Info_user.name}",
                                  style: const TextStyle(height: 1.4),
                                ),
                              ],
                            )),
                            BlocProvider (
                              create: (BuildContext context) => create_post_cubit(LoginInitialState_create_post()),
                              child: BlocConsumer<create_post_cubit, create_post>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  return TextButton(
                                      onPressed: () async{
                                        Data = Cash_Data();
                                        final DateTime now = DateTime.now();
                                        final DateFormat formatter = DateFormat('yyyy-MM-dd');
                                        final String formatted = formatter.format(now);
                                        var cheeck_id = await Data.getData(key: "user_id");
                                        var name = Get_Info_cubit.get(context).Info_user.name;
                                        dynamic image_profile = Get_Info_cubit.get(context).Info_user.image_profile;
                                        if (image_post == null)
                                          {
                                            Tosta_mes (mess: 'There must be a picture' ,color:Colors.red);
                                          }

                                        else {
                                          create_post_cubit.get(context)..create_post(name,"${cheeck_id}","${formatted}", "${post.text}","${name_image}" ,"${image_profile}");
                                        }

                                      },
                                      child:state is Loading_create_post ? CircularProgressIndicator():Text("post"),
                                  );
                                }
                              )
                            )
                          ],
                        );
                      })),
              New_post(),
              if (image_post !=null)
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                    children:  [
                          Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: Stack(
                              children: [
                                Container (
                                  width: double.infinity,
                                  child: Card(
                                    elevation: 10.0,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child:Image(
                                      image: FileImage(image_post) as ImageProvider,
                                      fit: BoxFit.cover,
                                      height: 200.0,
                                    ),

                                  )

                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    child:IconButton(
                                        onPressed:()
                                        {
                                          setState(() {
                                            image_post = null;
                                            name_image = null;
                                          });
                                        },
                                        icon: Icon(Icons.close)) ,),
                                ),
                              ],
                            )

                          ),
                    ]

                ),
                TextButton(
                  onPressed: () {
                    getImage_post();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.image_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Add Photo")
                    ],
                  )),
            ],
          )),
    );
  }
}
