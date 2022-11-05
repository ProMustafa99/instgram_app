import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgram/cah_helper/cach_helper.dart';
import 'package:instgram/cubit&state/Home/Home_cubit.dart';
import 'package:instgram/cubit&state/Home/Home_states.dart';
import 'package:instgram/post_model.dart';
import 'package:instgram/screen/content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
          create: (BuildContext context) => get_post(LoginInitialState_post())..Get_post(),
          child: BlocConsumer<get_post, post_states>(
            listener: (BuildContext context, state) {},
            builder: (BuildContext context, state) {
              return ConditionalBuilder(
                condition: get_post.get(context).posts_info.length > 0,
                builder: (BuildContext context) {
                  return SingleChildScrollView (
                      child: Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Post(
                                  get_post.get(context).posts_info[index],
                                  context,
                                  index),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 15.0,
                              ),
                              itemCount: get_post.get(context).posts_info.length,
                            )
                          ]
                      ),
                  );
                },
                fallback: (context) => Padding(
                  padding: EdgeInsets.all(10),
                    child:  LinearProgressIndicator(
                      semanticsLabel: 'Linear progress indicator',
                    ),
                  ),
              );

            },
          ),
        ));
  }




  Widget Post (post_model post_info ,context , index )
  {
     return BlocProvider(
           create: (BuildContext context) => get_post(LoginInitialState_post())..Get_post(),
            child: BlocConsumer<get_post, post_states>(
              listener: (BuildContext context, state) {},
              builder: (BuildContext context, state) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding (
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              backgroundImage: NetworkImage("${post_info.image_user}"),
                            ),
                            SizedBox(width: 10,),
                            Text("${post_info.name}"),
                          ],
                        ),
                      ),
                      Image(
                        width: double.infinity,
                        image: NetworkImage("${post_info.Post_image}"),
                        fit: BoxFit.cover,
                        height: 400,

                      ),
                      Padding (
                        padding: EdgeInsets.all(10),
                        child: Row (
                          children:
                          [
                            BlocProvider(
                                create: (BuildContext context) => get_post(LoginInitialState_post())..Get_post(),
                                child: BlocConsumer<get_post, post_states>(
                                    listener: (BuildContext context, state) {},
                                    builder: (BuildContext context, state) {
                                      return Row(
                                        children: [
                                          InkWell(
                                            child:  Icon(
                                              Icons.favorite_border,
                                              color: Colors.black,
                                              size:30 ,
                                            ),
                                            onTap: (){
                                              get_post.get(context).like_post(get_post.get(context).posts_id[index]);
                                              print(get_post.get(context).posts_id[index]);
                                            },
                                          ),
                                        ],
                                      );
                                    }

                                )

                            ),
                            SizedBox(width: 20,),
                            InkWell (
                              child:  Icon(
                                Icons.comment_outlined,
                                color: Colors.black,
                                size:30 ,
                              ),
                              onTap: () {},
                            ),
                            SizedBox(width: 20,),

                          ],
                        ) ,

                      ),

                      Padding (
                        padding: EdgeInsets.only(left: 15),
                        child: BlocProvider(
                          create: (BuildContext context) => get_post(LoginInitialState_post())..Get_post(),
                          child: BlocConsumer<get_post, post_states>(
                            listener: (BuildContext context, state) {},
                            builder: (BuildContext context, state) {
                              return Text("${get_post.get(context).likes[index]} likes");
                            }

                          )

                        )
                      ),
                      SizedBox(height: 10,),
                      Padding (
                        padding: EdgeInsets.only(left: 15),
                        child: Text("${post_info.Text}"),
                      ),
                      SizedBox(height: 10,),
                      Padding (
                        padding: EdgeInsets.only(left: 15),
                        child: Text("7 days ago " ,style: TextStyle(color: Colors.grey),),
                      ),

                    ],
                  ),
                );

              }
            )

     );

  }


}
