import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/authentication/presentation/screens/login_screen.dart';
import 'package:todo_app/authentication/presentation/screens/sign_up_screen.dart';
import 'package:todo_app/home/presentation/controllers/delete_todo_cubit/delete_todo_cubit.dart';
import 'package:todo_app/home/presentation/controllers/get_todo_cubit/get_todo_cubit.dart';
import 'package:todo_app/home/presentation/screens/detail_todo.dart';
import 'package:todo_app/home/presentation/screens/home_screen.dart';
import 'package:todo_app/home/presentation/screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations', // المسار للفايل بتاعك
      fallbackLocale: const Locale('en'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routes: {
        '/': (ctx) => LoginScreen(),
        HomeScreen.screenRoute: (context) => BlocProvider(
          create: (context) => GetTodoCubit()..getTodo(),
          child: HomeScreen(),
        ),
        SignUpScreen.screenRoute: (context) => SignUpScreen(),
        LoginScreen.screenRoute: (context) => LoginScreen(),
        DetailTodo.screenRoute: (context) => BlocProvider(
          create: (context) => DeleteTodoCubit(),
          child: DetailTodo(),
        ),
        ProfileScreen.screenRoute: (context) => ProfileScreen(),
      },
    );
  }
}
