
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:instgram/cah_helper/cach_helper.dart';
import 'package:instgram/cubit&state/Info_user/info_user_cubit.dart';
import 'package:instgram/cubit&state/Info_user/info_user_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:instgram/screen/content.dart';
import 'dart:io';

import 'package:instgram/screen/layout.dart';

class Edit_profile extends StatefulWidget {
  const Edit_profile({Key? key}) : super(key: key);

  @override
  State<Edit_profile> createState() => _Edit_profileState();
}

class _Edit_profileState extends State<Edit_profile> {

  var name = TextEditingController();

  var Phone = TextEditingController();

  var Email = TextEditingController();

  var Bio = TextEditingController();

  dynamic  image_profile;

  dynamic  image_cover;

  var  picker = ImagePicker();

  void update_image (var number , var image) async{

    Data = Cash_Data();
    var cheeck_id = await Data.getData(key: "user_id");

     //change cover image
      if(number ==1) {
        FirebaseFirestore.instance.collection("user").doc("${cheeck_id}").
        update({
          "image_cover":'${image}',

        }).
        then((value){

          Tosta_mes(mess: 'Done change your cover image  ', color: Colors.green);
          navigateto_and_push(context, layout());
        }).
        catchError((error_change_image_cover){});
      }

      //change profile image
      else {
        FirebaseFirestore.instance.collection("user").doc("${cheeck_id}").
        update({ "image_profile":'${image}',}).
        then((value) {
          Tosta_mes(mess: 'Done change your image profile ', color: Colors.green);
          navigateto_and_push(context, layout());
        }).
        catchError((error_change_image_profile){});
      }
  }

  Future getImage_profile() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if(pickedFile!=null)  {
      setState(()  {
         image_profile = File(pickedFile.path);
         firebase_storage.FirebaseStorage.instance.ref().
         child('user_image/${Uri.file(image_profile.path).pathSegments.last}').
         putFile(image_profile).
         then((value)
         {
           value.ref.getDownloadURL().
           then((value) async {

             update_image(2 , value);
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

  Future getImage_cover() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if(pickedFile!=null)  {
      setState(()  {
        image_cover = File(pickedFile.path);
        firebase_storage.FirebaseStorage.instance.ref().
        child('user_cover_image/${Uri.file(image_cover.path).pathSegments.last}').
        putFile(image_cover).
        then((value)
        {
          value.ref.getDownloadURL().
          then((value) async{

            update_image(1,value);

          }).
          catchError((error_upadte){});

        }).
        catchError((e){});

      });

    }
    else{
      print("No Image selectd");
    }

  }


  var _forKey = GlobalKey<FormState>();
  Widget Name() {
    return Container(

      child: Padding(
        padding: EdgeInsets.all(5),
        child: TextFormField(
          controller: name,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_circle),
            border: OutlineInputBorder(

            ),
            hintText: 'Enater You Name ',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter  Name';
            }
          },
        ),
      ),
    );
  }

  // Widget phone() {
  //
  //   return Container(
  //
  //     child: Padding(
  //       padding: EdgeInsets.all(5),
  //       child: TextFormField(
  //         controller: Phone,
  //         keyboardType:TextInputType.phone,
  //         decoration: InputDecoration(
  //           prefixIcon: Icon(Icons.phone),
  //           border: OutlineInputBorder(
  //
  //           ),
  //
  //           hintText: 'Enater You Phone ',
  //         ),
  //         validator: (value) {
  //           if (value == null || value.isEmpty) {
  //             return 'Please Enter  phone';
  //           }
  //         },
  //       ),
  //     ),
  //   );
  // }

  Widget email() {

    return Container(

      child: Padding(
        padding: EdgeInsets.all(5),
        child: TextFormField(
          controller: Email,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(

            ),

            hintText: 'Enater You Email ',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter  Email';
            }
          },
        ),
      ),
    );
  }

  Widget bio() {

    return Container(

      child: Padding(
        padding: EdgeInsets.all(5),
        child: TextFormField(
          controller: Bio,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.messenger),
            border: OutlineInputBorder(

            ),

            hintText: 'Enater You Email ',
          ),

        ),
      ),
    );
  }


  Widget Save_Data()
  {
    return BlocProvider (
      create: (BuildContext context) => Get_Info_cubit(LoginInitialState_Get_Info()),
      child: BlocConsumer<Get_Info_cubit , Info_user>(
        listener: (context, state){},
        builder: (context , state) {
          return  ConditionalBuilder(
            condition: state is !Loading_Change_Data,
            builder: (context) {
              return Container(
                width: double.infinity,
                child: RaisedButton
                  (
                  onPressed: () {

                    if(_forKey.currentState!.validate())
                    {
                      Get_Info_cubit.get(context).Chang_Date_user(context,name.text, Email.text, Bio.text);
                    }

                    else {
                      Tosta_mes(mess: "Null ", color: Colors.red);
                    }
                  },
                  color: Colors.blue,
                  child: Text("Save Change" , style: TextStyle(fontSize: 20, color: Colors.white),),
                ),
              );
            },
            fallback: (BuildContext context) {
              return CircularProgressIndicator();
            },
          );
        },
      ),

    );
  }

  initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider (
      create: (BuildContext context) => Get_Info_cubit(LoginInitialState_Get_Info())..Data_user(),
      child: BlocConsumer<Get_Info_cubit , Info_user>(
        listener: (context ,states){},
        builder:  (context ,states){
          name.text  =  Get_Info_cubit.get(context).Info_user.name;
          Email.text = Get_Info_cubit.get(context).Info_user.email;
          Bio.text   = Get_Info_cubit.get(context).Info_user.bio;
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: _forKey,
              child: SingleChildScrollView(
                child: Column(
                  children:
                  [
                    Container(
                      height: 270.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Card(
                                    elevation: 10.0,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child:Image(
                                      image: image_cover ==null ? NetworkImage("${Get_Info_cubit.get(context).Info_user.image_cover}"):FileImage(image_cover) as ImageProvider,
                                      fit: BoxFit.cover,
                                      height: 200.0,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    child:IconButton( onPressed:()
                                    {
                                      getImage_cover();
                                    }, icon: Icon(Icons.camera_alt_outlined)) ,),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children:
                            [
                              CircleAvatar(
                                radius: 60.0,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 55.0,
                                  backgroundImage: (image_profile ==null) ? NetworkImage("${Get_Info_cubit.get(context).Info_user.image_profile}"): FileImage(image_profile) as ImageProvider,

                                ),
                              ),
                              CircleAvatar(
                                radius: 18,
                                child:IconButton(onPressed:(){
                                  getImage_profile();
                                }, icon: Icon(Icons.camera_alt_outlined,size: 18,)) ,),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding (
                      padding:EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Name(),
                          email(),
                          bio(),
                          Save_Data(),

                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ) ,
          );

        },
      ),
      );
  }
}