import 'package:chatapplication/layouts/cubit/cubit.dart';
import 'package:chatapplication/layouts/cubit/state.dart';
import 'package:chatapplication/modules/loginscreen/loginscreen.dart';
import 'package:chatapplication/shared/components/components.dart';
import 'package:chatapplication/shared/constats.dart';
import 'package:chatapplication/shared/network/local/cache_helper.dart';
import 'package:chatapplication/shared/styles/IconBroken.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class homeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder:(context,state)=> Scaffold(
        appBar: AppBar(
          title: Text(
            'Social App',
          ),
          actions: [
            defaultTextButton(
              text: 'Signout',
              TextColor: Colors.grey,
              function: (){
                CacheHelper.removedata('uId').then(
                        (value)
                    {
                      navigatToAndFinish(context,loginScreen());
                    }
                ).catchError(
                        (error)
                    {
                      print(error.toString());
                    });
              }
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ConditionalBuilder(
            condition: FirebaseAuth.instance.currentUser!.emailVerified,
                builder: (context)=>SizedBox(),
                fallback:(context)=> Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  color: Colors.amber.withOpacity(0.5),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                              'Send Verification Message',
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                      ),
                      defaultTextButton
                        (
                        text: 'Send',
                        TextColor: Colors.green,
                        function: (){
                          FirebaseAuth.instance.currentUser!.sendEmailVerification();
                          FirebaseAuth.instance.currentUser!.linkWithPhoneNumber('01551634779');
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SocialCubit.get(context).BottomNavScrreen[SocialCubit.get(context).mainIndex!],
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: SocialCubit.get(context).currentIndex,
          onTap:(index)
          {
            SocialCubit.get(context).changeBottomNav(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                  IconBroken.Home
              ),
              label: 'Home'
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  IconBroken.Chat
              ),
              label: 'Chats'
            ),
            BottomNavigationBarItem(
              icon: Container(
                height: 30,
                width: 30,
                decoration:BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Icon(
                    IconBroken.Upload,
                  color: Colors.white,
                ),
              ),
              label: 'Post',
              tooltip:'Create Post'

            ),
            BottomNavigationBarItem(
              icon: Icon(
                  IconBroken.Location
              ),
              label: 'Users'
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  IconBroken.User1
              ),
              label: 'Profile'
            ),
          ],
        ),
      ),
    );
  }
}
