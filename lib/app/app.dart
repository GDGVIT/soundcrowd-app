import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_collab_app/app/router/router.dart';
import 'package:spotify_collab_app/app/theme/theme.dart';

class SoundCrowdApp extends ConsumerWidget {
  const SoundCrowdApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.read(routerProvider);

    return MaterialApp.router(
      title: 'SoundCrowd',
      theme: darkTheme,
      // themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
    );
  }
}
