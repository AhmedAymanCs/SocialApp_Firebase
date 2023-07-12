import 'package:chatapplication/layouts/cubit/cubit.dart';
import 'package:chatapplication/layouts/cubit/state.dart';
import 'package:chatapplication/models/userModel/userModel.dart';
import 'package:chatapplication/shared/components/components.dart';
import 'package:chatapplication/shared/styles/IconBroken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class editProfileScreen extends StatelessWidget {

  var emailControlller =TextEditingController();
  var phoneControlller =TextEditingController();
  var nameControlller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    UserModel? model = SocialCubit.get(context).model;
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state)
      {
        emailControlller.text=model!.email!;
        nameControlller.text= model.name!;
        phoneControlller.text=model.phone!;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: ()
              {
                Navigator.pop(context);
              }, icon: Icon(
              IconBroken.Arrow___Left_2,

            ),
            ),
            titleSpacing: 0.0,
            title: Text
              (
              'Edit Your Profile',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            actions: [
              defaultTextButton(
                function: (){
                  model.email = emailControlller.text;
                  model.name = nameControlller.text;
                  model.phone = phoneControlller.text;
                  SocialCubit.get(context).updateUserData();
                },
                text: 'Update'
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child:model.coverImage == null ?  Image.network(
                            'https://toppng.com/uploads/preview/person-vector-11551054765wbvzeoxz2c.png' ,
                            fit: BoxFit.cover,
                            height: 150,
                            width: double.infinity,
                          ) : Image.network(
                           model.coverImage!,
                            fit: BoxFit.cover,
                            height: 150,
                            width: double.infinity,
                          ),
                        ),
                        InkWell(
                          onTap: ()
                          {
                            SocialCubit.get(context).getProfileImage();
                          },
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                radius: 62,
                              ),
                              CircleAvatar(
                                backgroundImage: model.profileImage == null ?  NetworkImage(
                                    'https://toppng.com/uploads/preview/person-vector-11551054765wbvzeoxz2c.png',
                                ) :  NetworkImage(
                                  model.profileImage!,
                                ) ,
                                radius: 60,
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultTextFormField(
                    controller: nameControlller,
                    label: 'Name',
                    preicon: IconBroken.User,
                    validate: (value)
                    {
                      if(value!.isEmpty)
                        return'Name must be not empty';
                    },
                    type: TextInputType.name,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    controller: emailControlller,
                    label: 'Email',
                    preicon: IconBroken.Message,
                    validate: (value)
                    {
                      if(value!.isEmpty)
                        return'Email must be not empty';
                    },
                    type: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    controller: phoneControlller,
                    label: 'Phone',
                    preicon: IconBroken.Call,
                    validate: (value)
                    {
                      if(value!.isEmpty)
                        return'Phone must be not empty';
                    },
                    type: TextInputType.phone,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}