import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_collab_app/constants/constants.dart';
import 'package:spotify_collab_app/providers/auth_provider.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectScreen extends ConsumerStatefulWidget {
  const ConnectScreen({super.key});

  @override
  ConnectScreenState createState() => ConnectScreenState();
}

class ConnectScreenState extends ConsumerState<ConnectScreen> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _initUniLinks();
  }

  Future<void> _initUniLinks() async {
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        final accessToken = uri.queryParameters['token'];
        if (accessToken != null) {
          log('Access Token: $accessToken');

          ref.read(authProvider.notifier).setAccessToken(accessToken);
          if (!mounted) return;
          context.replace('/home');
        } else {
          log('No access token found');
        }
      }
    }, onError: (err) {
      log('Error in listening to URI links: $err');
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> _launchSpotifyLogin() async {
    const url = '$devUrl/v1/auth/spotify/login/app';
    launchUrl(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5822EE),
      body: Stack(children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SvgPicture.asset(
            'assets/bg_splash.svg',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              const Spacer(),
              const Text(
                "Welcome To Collabify",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Gotham",
                  fontSize: 45,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Unlock a world of music possibilities by connecting your "
                "Spotify account and dive into a seamless experience tailored "
                "just for you.",
                style: TextStyle(
                  fontFamily: "Product-Sans",
                  fontSize: 16.53,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  _launchSpotifyLogin();
                },
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xff1db954),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  height: 45,
                  width: 225,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Connect",
                        style: TextStyle(
                          fontFamily: "Gotham",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset("assets/logo.svg")
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Authorize Collabify to access your Spotify account, "
                "enabling you to explore, play and share music with friends "
                "effortlessly.",
                style: TextStyle(
                    fontFamily: "Gotham",
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    backgroundColor: Color.fromARGB(13, 0, 0, 0)),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
            ],
          ),
        ),
      ]),
    );
  }
}
