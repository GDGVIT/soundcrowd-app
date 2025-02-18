import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_collab_app/view/screens/admin_screen.dart';
import 'package:spotify_collab_app/view/screens/create_screen.dart';
import 'package:spotify_collab_app/view/screens/join_screen.dart';
import 'package:spotify_collab_app/view/screens/login_screen.dart';
import 'package:spotify_collab_app/view/screens/signup_screen.dart';
import 'package:spotify_collab_app/view/screens/home_screen.dart';
import 'package:spotify_collab_app/view/screens/connect_screen.dart';
import 'package:spotify_collab_app/view/screens/splash_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => const MaterialPage(
          child: SplashScreen(),
        ),
      ),
      GoRoute(
        path: '/connect',
        pageBuilder: (context, state) => const MaterialPage(
          child: ConnectScreen(),
        ),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => const MaterialPage(
          child: HomeScreen(),
        ),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => const MaterialPage(
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/signup',
        pageBuilder: (context, state) => const MaterialPage(
          child: SignupScreen(),
        ),
      ),
      GoRoute(
        path: '/create',
        pageBuilder: (context, state) => const MaterialPage(
          child: CreateScreen(),
        ),
      ),
      GoRoute(
        path: '/join',
        pageBuilder: (context, state) => const MaterialPage(
          child: JoinScreen(),
        ),
      ),
      GoRoute(
        path: '/admin',
        pageBuilder: (context, state) => const MaterialPage(
          child: AdminScreen(),
        ),
      ),
    ],
  );
});
