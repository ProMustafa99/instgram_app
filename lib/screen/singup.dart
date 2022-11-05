import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgram/cubit&state/signup_page/signup_cubit.dart';
import 'package:instgram/cubit&state/signup_page/signup_state.dart';
import 'package:hexcolor/hexcolor.dart';
class signup_page extends StatefulWidget {
  const signup_page({Key? key}) : super(key: key);

  @override
  State<signup_page> createState() => _signup_pageState();
}

class _signup_pageState extends State<signup_page> {
  var Name = TextEditingController();

  var email = TextEditingController();

  var Password1 = TextEditingController();

  var Password2 = TextEditingController();

  var _forKey = GlobalKey<FormState>();

  bool Show_password =true;

  bool Show_repassword =true;

  double size_box = 18;


  Widget name()
  {
    return Padding(
      padding: const EdgeInsets.only(left:15),
      child: Container(
        width: double.infinity,
        height: 60,
        child:TextFormField
          (
          controller: Name,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon:Icon(Icons.supervised_user_circle),
            hintText: 'Enter Your Name',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Your Name';
            }
          },

        ) ,
      ),
    );
  }

  Widget Email()
  {
    return Padding(
      padding: const EdgeInsets.only(left:15),
      child: Container(
        width: double.infinity,
        child:TextFormField
          (

          controller: email,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon:Icon(Icons.email),
            hintText: 'Enter your Email',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Email';
            }
          },

        ) ,
      ),
    );
  }

  Widget password1()
  {
    return Padding(
      padding: const EdgeInsets.only(left:15),
      child: Container(
        width: double.infinity,
        height: 60,
        child:TextFormField
          (
          obscureText:Show_password,
          controller: Password1,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon:Icon(Icons.vpn_key_rounded),
            hintText: 'Password ',
            suffixIcon:  IconButton(
                onPressed: ()
                {
                  setState(()
                  {
                    Show_password = !Show_password; // false - true
                    print(Show_password);
                  });
                },

                icon: Icon(Show_password?Icons.visibility_off :Icons.visibility)
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Password ';
            }
          },

        ) ,
      ),
    );
  }

  Widget password2()
  {
    return Padding(
      padding: const EdgeInsets.only(left:15),
      child: Container(
        width: double.infinity,
        height: 60,
        child:TextFormField
          (
          obscureText: Show_repassword,
          controller: Password2,
          decoration: InputDecoration(

            border: OutlineInputBorder(),
            prefixIcon:Icon(Icons.vpn_key),
            hintText: 'Confirm Password',
            suffixIcon:  IconButton(
                onPressed: ()
                {
                  setState(()
                  {
                    Show_repassword = !Show_repassword; // false - true
                  });
                },

                icon: Icon(Show_repassword?Icons.visibility_off :Icons.visibility)
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Confirm password ';
            }
          },

        ) ,
      ),
    );
  }

  Widget button_sign_up()  {
      return BlocProvider (
        create: (BuildContext context) => Signup_cubit(LoginInitialState_siginup()),
        child: BlocConsumer<Signup_cubit , siginup_State>(
          listener: (context, state){},
           builder: (context , state) {
             return ConditionalBuilder (
               condition: state is !Loading_siginup,
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
                            Signup_cubit.get(context).Create_new_account(context ,Name.text.trim(),email.text.trim(),Password1.text.trim());
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
           }
        )


      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(),
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.only(top: 40 ,right: 10),
          child: Form(
            key: _forKey,
            child: Center (
              child: Column(
                children: [
                   Text("Soical App Signup " ,style: TextStyle(fontSize: 40 ,fontFamily: "Schyler"),),
                   SizedBox(height: size_box,),
                    name(),
                   SizedBox(height: size_box,),
                    Email(),
                  SizedBox(height: size_box,),
                    password1(),
                  SizedBox(height: size_box,),
                    password2(),
                  SizedBox(height: size_box,),
                  button_sign_up()

                ],
              ),
            ),
          ),
        ),
      )

    );
  }
}
