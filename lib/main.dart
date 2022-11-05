import 'package:flutter/material.dart';
import 'package:instgram/cah_helper/cach_helper.dart';
import 'package:instgram/cubit&state/Home/Home_cubit.dart';
import 'package:instgram/cubit&state/Home/Home_states.dart';
import 'package:instgram/cubit&state/dark_light_mode/mode_cubit.dart';
import 'package:instgram/cubit&state/dark_light_mode/mode_state.dart';
import 'package:instgram/screen/Test_on_project.dart';
import 'package:instgram/screen/content.dart';
import 'package:instgram/screen/layout.dart';
import 'package:instgram/screen/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instgram/screen/setting.dart';
import 'package:instgram/screen/singup.dart';
import 'package:instgram/style.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

   Data = Cash_Data();
  var cheeck_id = await Data.getData(key: "user_id");
  Widget Screen;

  if (cheeck_id == null) {
    Screen = login_page();

  } else {
    Screen = layout();
  }
  runApp(MyApp(Screen = Screen));

}

class MyApp extends StatelessWidget {
  final stratWidget;
  MyApp(this.stratWidget);

  @override

  Widget build(BuildContext context) {

    return BlocProvider (
      create: (BuildContext context) => mode_cubit(LoginInitialState_mode()),
      child: BlocConsumer<mode_cubit,states_mode> (
        listener: (context, state){},
        builder:  (context, state) {
          return MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) => get_post(LoginInitialState_post())..Get_post()),
              ],

              child: MaterialApp (
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: mode_cubit.get(context).mode_dark_light?dark:light,
                  home: stratWidget
              ));
        }
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: null
    );
  }
}
