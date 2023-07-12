import 'package:bloc/bloc.dart';
import 'package:chatapplication/modules/loginscreen/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit(): super(initialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

 bool isPassword =true;
 void changePasswordVisablity()
 {
   isPassword = !isPassword;
   emit(changePasswordVisablityState());
 }

 void userLogin({
  required String email,
   required String password
})
 {
   emit(LoginLoadingState());
   FirebaseAuth.instance.signInWithEmailAndPassword(
       email: email,
       password: password
   ).then(
           (value)
       {
         emit(LoginSucsessState(value.user!.uid));
       }
   ).catchError(
           (error)
       {
         emit(LoginErrorState(error.toString()));
       }
   );
 }
}