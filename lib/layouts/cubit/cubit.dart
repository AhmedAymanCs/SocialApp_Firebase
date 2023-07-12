import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chatapplication/layouts/cubit/state.dart';
import 'package:chatapplication/models/userModel/userModel.dart';
import 'package:chatapplication/modules/SocialScreens/chats/chats_screen.dart';
import 'package:chatapplication/modules/SocialScreens/home/home_screen.dart';
import 'package:chatapplication/modules/SocialScreens/profile/profile_screen.dart';
import 'package:chatapplication/modules/SocialScreens/users/users_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SocialCubit extends Cubit<SocialState>
{
  SocialCubit(): super(InitialAppState());

  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;
  int? mainIndex=0;
 void changeBottomNav(int index)
 {
   if(index==2)
     {

     }
   else if (index>2)
     {
       currentIndex=index;
       mainIndex=index-1;
       emit(ChangeBottomNavState());
     }
   else
     {
       currentIndex=index;
       mainIndex=currentIndex;
       emit(ChangeBottomNavState());
     }

 }

 List<Widget> BottomNavScrreen=[
   HomeScreen(),
   ChatsScreen(),
   usersScreen(),
   ProfileScreen(),
 ];

 UserModel? model;
 void getUserData()
 {
   FirebaseFirestore
       .instance.collection('users')
   .doc(FirebaseAuth.instance.currentUser!.uid)
       .get()
       .then
     (
           (value)
       {
       model = UserModel.fromJason(value.data());
       emit(getUserDataSucssesState());
       }
   ).catchError(
           (error)
       {
         emit(getUserDataErrorState());
       });
 }


 void updateUserData()
 {
   FirebaseFirestore
       .instance
       .collection('users')
       .doc(model!.uId)
       .set(model!.toMap())
        .then((value)
        {
        emit(updateUserDataSucssesState());
        uploadProfileImage();
        getUserData();
        }
        ).catchError((error)
   {
     emit(updateUserDataErrorState());
   }
   );
 }

 File? profileImage;
  ImagePicker picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }


  void uploadProfileImage()
  {
  FirebaseStorage
      .instance
      .ref()
      .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
      .putFile(profileImage!).then((value)async
  {
    model!.profileImage = await value.ref.getDownloadURL();
  });

  }
}