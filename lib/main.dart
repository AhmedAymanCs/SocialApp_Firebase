import 'package:bloc/bloc.dart';
import 'package:chatapplication/layouts/cubit/cubit.dart';
import 'package:chatapplication/layouts/cubit/state.dart';
import 'package:chatapplication/layouts/homeLayout.dart';
import 'package:chatapplication/modules/loginscreen/loginscreen.dart';
import 'package:chatapplication/modules/onBoarding.dart';
import 'package:chatapplication/shared/bloc_observer.dart';
import 'package:chatapplication/shared/network/local/cache_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  Widget widget;
  String uId=CacheHelper.getData('uId')??'';

  if(CacheHelper.getData('onboarding')!=null)
    {

      if(uId !='')
        {
          widget=homeLayout();
        }
      else
        {
          widget=loginScreen();
        }

    }
  else
    {
      widget=on_boarding();
    }
  
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
Widget widget;
MyApp(this.widget,{super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider
          (
            create:(context)=>SocialCubit()..getUserData()
        ),
      ],
      child: BlocConsumer<SocialCubit,SocialState>(
        listener: (context,state){},
        builder:(context,state)=> MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                color:Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
              actionsIconTheme: IconThemeData(
                color: Colors.black
              ),
                  iconTheme: IconThemeData(
                    color: Colors.black
                  ),
                  color: Colors.white,
              elevation: 0,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              enableFeedback: true,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.deepOrange
            )
          ),
          darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: AppBarTheme(
                titleTextStyle: TextStyle(
                    color:Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
                actionsIconTheme: IconThemeData(
                    color: Colors.white
                ),
                color: Colors.black,
                elevation: 0,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  enableFeedback: true,
                  type: BottomNavigationBarType.fixed,
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: Colors.deepOrange,
                backgroundColor: Colors.black
              ),
              textTheme: TextTheme(
                // bodyLarge: TextStyle(
                //   color: Colors.white
                // ),
                caption: TextStyle(
                    color: Colors.grey
                ),
                bodyText1: TextStyle(
                  color: Colors.white
                )
              ),
            cardTheme: CardTheme(
              shadowColor: Colors.grey,
                  color: Colors.black
            )
          ),
          themeMode: ThemeMode.light,
          home: widget,
        ),
      ),
    );
  }
}

