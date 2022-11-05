import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgram/cubit&state/login_cubit/login-cubit.dart';
import 'package:instgram/cubit&state/login_cubit/login-state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:instgram/screen/content.dart';
import 'package:instgram/screen/singup.dart';
class login_page extends StatefulWidget {


  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {

  var Email = TextEditingController();

  var Password = TextEditingController();

  var _forKey = GlobalKey<FormState>();

  var User_Id = "LOGIN";

  var x = 0;
  bool Show_password = false;
  bool isPassword = true;

  Widget email() {
    return Container(

      child: Padding(
        padding: EdgeInsets.all(5),
        child: TextFormField(
          controller: Email,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),),

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

  Widget password() {
    IconData ic = Icons.visibility_off;
    return Padding(
      padding: EdgeInsets.all(5),
      child: TextFormField(
        controller: Password,
        obscureText: Show_password,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  Show_password = !Show_password;
                  if (Show_password) {
                    setState(() {
                      ic = Icons.visibility;
                    });
                  }
                  else {
                    setState(() {
                      ic = Icons.visibility_off;
                    });
                  }
                });
              },

              icon: Icon(
                  Show_password ? Icons.visibility_off : Icons.visibility)
          ),
          prefixIcon: Icon(Icons.vpn_key_rounded),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),),
          hintText: 'Enter Password',

        ),

        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some password';
          }
        },
      ),
    );
  }

  Widget button_login()
  {
     return BlocProvider (
        create: (BuildContext context) => login_cubit(LoginInitialState()),
        child: BlocConsumer<login_cubit , login_State>(
          listener: (context, state){},
          builder: (context , state) {
            return ConditionalBuilder (
                condition: state is !Loading,
                builder: (context) {
                   return Padding (

                      padding: EdgeInsets.all(8.0),
                       child: Container(
                       width: 600,
                       height: 50,
                       child: RaisedButton
                         (
                         onPressed:  (){
                           if(_forKey.currentState!.validate())
                           {
                             login_cubit.get(context).login(context , Email.text.trim(),Password.text.trim());
                           }
                         },
                         child:Text("Login" ,style:TextStyle(fontSize: 25, color: Colors.white) ,) ,
                         shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
                         color: HexColor("#f25e30"),

                       ),
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



  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(3.0),
            child: Form(
              key: _forKey,
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                [
                  Image.asset("assets/login/login.jpg"),
                  const SizedBox(height: 10,),
                  email(),
                  const SizedBox(height: 10,),
                  password(),
                  const SizedBox(height: 10,),
                  button_login(),
                  Divider(
                    height: 20,
                    color: Colors.red,

                  ),
                  TextButton(
                    onPressed: () {
                      navigateto_page(context , signup_page());
                    },
                    child: Text("Sign up email or phone", style: TextStyle(fontSize: 15),),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
