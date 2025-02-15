import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_collab_app/app/app.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/foundation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  final packageInfo = await PackageInfo.fromPlatform();

  await SentryFlutter.init(
    (options) {
      options.dsn = dotenv.env['SENTRY_DSN'];
      options.environment = kReleaseMode ? 'production' : 'development';
      options.tracesSampleRate = 1.0;
      options.profilesSampleRate = 1.0;
      options.release = '${packageInfo.version}+${packageInfo.buildNumber}';
    },
    appRunner: () => runApp(
      const ProviderScope(
        child: SoundCrowdApp(),
      ),
    ),
  );
}
