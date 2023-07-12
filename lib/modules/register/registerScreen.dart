import 'package:chatapplication/modules/register/cubit/cubit.dart';
import 'package:chatapplication/modules/register/cubit/states.dart';
import 'package:chatapplication/shared/components/components.dart';
import 'package:chatapplication/shared/constats.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../loginscreen/loginscreen.dart';

class registerScreen extends StatelessWidget {
  var nameController =TextEditingController();
  var emailController =TextEditingController();
  var passwordController =TextEditingController();
  var phoneController =TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is userRegisterErrorState)
            {
              Fluttertoast.showToast(
                msg: state.error,
                backgroundColor: Colors.red,
                toastLength: Toast.LENGTH_LONG
              );
            }
          if(state is userCreateSucsessState)
            {
              Fluttertoast.showToast(
                  msg: 'Account has been created',
                  backgroundColor: Colors.green,
                  toastLength: Toast.LENGTH_LONG
              );
              navigatToAndFinish(context, loginScreen(email: emailController.text,));
            }

        },
          builder:(context,state)=>Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,

            ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsetsDirectional.only(
              start: 20,
              bottom: 20,
              top: 90,
                end: 20,
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  defaultTextFormField(
                    controller: nameController,
                    preicon: Icons.person,
                    label: 'User Name',
                    type: TextInputType.name,
                    validate: (value){
                      if(value!.isEmpty)
                      {
                        return 'User name must be not empty';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                      controller: emailController,
                    preicon: Icons.email,
                    label: 'Email Address',
                    type: TextInputType.emailAddress,
                    validate: (value){
                        if(value!.isEmpty)
                          {
                            return 'Email Address must be not empty';
                          }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    controller: passwordController,
                    label: 'Password',
                    type: TextInputType.visiblePassword,
                    isSecure: RegisterCubit.get(context).isPassword,
                    suficon: RegisterCubit.get(context).isPassword ? Icons.visibility: Icons.visibility_off,
                    sufixOnPressed:(){ RegisterCubit.get(context).changePasswordRegisterVisablity();},
                    validate: (value){
                      if(value!.isEmpty)
                      {
                        return 'Password must be not empty';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    label: 'Confirm Password',
                    type: TextInputType.visiblePassword,
                    isSecure: RegisterCubit.get(context).isPassword,
                    validate: (value){
                      if(value!.isEmpty)
                      {
                        return 'Password must be not empty';
                      }
                      if(value != passwordController.text)
                        return 'Password isn\`t match';
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    controller: phoneController,
                    preicon: Icons.phone,
                    label: 'Phone',
                    type: TextInputType.phone,
                    validate: (value){
                      if(value!.isEmpty)
                      {
                        return 'Phone must be not empty';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
              Container(
                      width: double.infinity,
                      color: Colors.blue,
                      height: 50,
                      child:ConditionalBuilder(
                        condition: state is userRegisterLoadingState,
                        builder:(context)=>
                            Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            )
                            ),
                             fallback:(context)=> defaultTextButton(
                              TextColor: Colors.white,
                            text: 'Register',
                            function: ()
                           {
                             if(formKey.currentState!.validate())
                               {
                              RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text);

                                   }

                        },
                      ),
                    ),
              ),
                ],

              ),
            ),
          ),

        ),
      ),
    );
  }
}
