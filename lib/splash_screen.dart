import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/home/presentation/screens/home_screen.dart';
import 'package:todo_app/authentication/presentation/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String screenRoute = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    await Future.delayed(const Duration(seconds: 2)); // وقت اللوجو أو الأنيميشن
    var user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // المستخدم مسجّل دخول
      Navigator.pushReplacementNamed(context, HomeScreen.screenRoute);
    } else {
      // مفيش مستخدم
      Navigator.pushReplacementNamed(context, LoginScreen.screenRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SvgPicture.asset('assets/images/Group.svg')),
    );
  }
}
