import 'package:chatapplication/layouts/homeLayout.dart';
import 'package:chatapplication/modules/loginscreen/cubit/cubit.dart';
import 'package:chatapplication/modules/loginscreen/cubit/states.dart';
import 'package:chatapplication/modules/register/registerScreen.dart';
import 'package:chatapplication/shared/components/components.dart';
import 'package:chatapplication/shared/constats.dart';
import 'package:chatapplication/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class loginScreen extends StatelessWidget {
var emailController =TextEditingController();
var passwordController =TextEditingController();
var formkey=GlobalKey<FormState>();
loginScreen({String email='',})
{
  emailController.text=email;
}
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>LoginCubit(),
     child:  BlocConsumer<LoginCubit,LoginStates>(
       listener: (context,state){
         if(state is LoginErrorState)
           {
             Fluttertoast.showToast(
                 msg: state.error,
               backgroundColor: Colors.red,
               toastLength: Toast.LENGTH_LONG,
             );
           }

         if(state is LoginSucsessState)
           {
             CacheHelper.putData('uId', state.uId)!.then(
                     (value)
                 {
                   navigatToAndFinish(context, homeLayout());
                 }
             ).catchError(
                     (error)
                 {
                   print(error.toString());
                 }
             );
           }
       },
         builder:(context,state)=> Scaffold(
          appBar: AppBar(
            title: Text(
              'Login',
            ),
          ),
          body: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                    'Login to join our application',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                defaultTextFormField(
                  type: TextInputType.emailAddress,
                    controller:emailController,
                  label: 'Email Address',
                  preicon: Icons.email,
                  validate: (value)
                    {
                      if(value!.isEmpty)
                        return 'Email Address must be not empty';
                    },
                ),
                SizedBox(
                  height: 20,
                ),
                defaultTextFormField(
                  type: TextInputType.visiblePassword,
                  controller:passwordController,
                  label: 'Password',
                  isSecure:LoginCubit.get(context).isPassword,
                  suficon: LoginCubit.get(context).isPassword ? Icons.visibility : Icons.visibility_off,
                  sufixOnPressed: (){
                    LoginCubit.get(context).changePasswordVisablity();
                  },
                  validate: (value)
                  {
                    if(value!.isEmpty)
                      return 'Password must be not empty';
                  },
                ),

              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 20
                ),
                width: double.infinity,
                color: Colors.blue,
                height: 50,
                child: ConditionalBuilder(
                    condition: state is LoginLoadingState,
                    builder:(context)=>
                        Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            )
                        ),
                    fallback:(context)=> defaultTextButton(
                    text: 'Login',
                    TextColor: Colors.white,
                    function: (){
                      if(formkey.currentState!.validate())
                        {
                        LoginCubit.get(context).userLogin(
                            email: emailController.text,
                            password: passwordController.text
                        );
                        }
                    }
                  ),
                ),
              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\`t have an account ?'),
                    defaultTextButton(
                      text: 'Register',
                      TextColor: Colors.blue,
                      function: (){
                        navigatTo(context, registerScreen());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
     ),
    );
  }
}
