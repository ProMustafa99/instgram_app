//
// import 'package:flutter/material.dart';
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:instgram/cubit&state/Info_user/info_user_cubit.dart';
// import 'package:instgram/cubit&state/Info_user/info_user_states.dart';
//
// class test extends StatefulWidget {
//   const test({Key? key}) : super(key: key);
//
//   @override
//   State<test> createState() => _test();
// }
//
// class _test extends State<test> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider (
//       create: (BuildContext context) => Get_Info_cubit(LoginInitialState_Get_Info())..Data_user(),
//       child: BlocConsumer<Get_Info_cubit , Info_user>(
//         listener: (context, state){},
//         builder: (context , state) {
//           return Scaffold(
//             appBar: AppBar(),
//             body: Column (
//                children: [
//                  Text("Vaule ==> ${Get_Info_cubit.get(context).Name}"),
//                ],
//             ) ,
//           );
//         }
//       ),
//     );
//   }
// }
//
