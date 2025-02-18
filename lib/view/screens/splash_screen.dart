import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await wait();
    await _checkForToken();
  }

  Future<void> wait() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> _checkForToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');

    if (!mounted) return;

    if (accessToken != null) {
      context.pushReplacement('/home');
    } else {
      context.pushReplacement('/connect');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/splash.svg',
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );
  }
}
