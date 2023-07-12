import 'package:chatapplication/layouts/cubit/cubit.dart';
import 'package:chatapplication/layouts/cubit/state.dart';
import 'package:chatapplication/modules/SocialScreens/profile/editPofile_Screen.dart';
import 'package:chatapplication/shared/constats.dart';
import 'package:chatapplication/shared/styles/IconBroken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder:(context,state)
      {
        return Column(
          children: [
            Container(
              height: 200,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child:SocialCubit.get(context).model!.coverImage == null ? Image.network(
                      'https://toppng.com/uploads/preview/person-vector-11551054765wbvzeoxz2c.png',
                    ) : Image.network(
                      SocialCubit.get(context).model!.coverImage!,
                      fit: BoxFit.cover,
                      height: 150,
                      width: double.infinity,
                    ),
                  ),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        radius: 62,
                      ),
                      CircleAvatar(
                        backgroundImage:SocialCubit.get(context).model!.profileImage == null ? NetworkImage(
                            'https://toppng.com/uploads/preview/person-vector-11551054765wbvzeoxz2c.png',
                        ) : NetworkImage(
                          SocialCubit.get(context).model!.profileImage!,
                        ),
                        radius: 60,
                      ),

                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
        SocialCubit.get(context).model!.name!,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 25
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              SocialCubit.get(context).model!.bio == null ? '' : SocialCubit.get(context).model!.bio! ,
              style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 15
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '100',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 15
                        ),
                      ),
                      Text(
                        'Posts',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '100',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 15
                        ),
                      ),
                      Text(
                        'Posts',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '100',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 15
                        ),
                      ),
                      Text(
                        'Posts',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '100',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 15
                        ),
                      ),
                      Text(
                        'Posts',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                      onPressed: (){
                        navigatTo(context, editProfileScreen());
                      },
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                            color: Colors.grey
                        ),
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: OutlinedButton(
                      onPressed: (){},
                      child: Icon(
                        IconBroken.Edit,
                        color: Colors.grey,
                      )
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
