import 'package:bloc/bloc.dart';
import 'package:chatapplication/models/userModel/userModel.dart';
import 'package:chatapplication/modules/loginscreen/cubit/states.dart';
import 'package:chatapplication/modules/register/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit(): super(initialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);

 bool isPassword =true;

 void changePasswordRegisterVisablity()
 {
   isPassword = !isPassword;
   emit(changePasswordRegisterVisablityState());
 }

 void userRegister({
  required String? name,
  required String email,
  required String password,
  required String? phone,
})
 {
  emit(userRegisterLoadingState());

  FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password
  ).then(
          (value) {
            createUser(
                name: name,
                email:email,
                phone: phone,
                uId: value.user!.uid
            );
  }).catchError(
          (error)
      {
        print(error.toString());
        emit(userRegisterErrorState(error.toString()));
      }
  );
 }

 void createUser(
  {
    required String? name,
    required String? email,
    required String? phone,
    required String? uId,
  }
     )
 {
   emit(userCreateLoadingState());
   UserModel model = UserModel(
       name,
       email,
       phone,
       uId,
   );

   FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value)
   {
    emit(userCreateSucsessState());
   }).catchError(
       (error)
   {
     emit(userCreateErrorState(error.toString()));
   }
   );


 }

}