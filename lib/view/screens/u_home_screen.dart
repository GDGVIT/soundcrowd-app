import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_collab_app/view/widgets/u_now_playing.dart';
import 'package:spotify_collab_app/view/widgets/u_recent_card.dart';
import 'package:spotify_collab_app/view/widgets/u_song_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(right: 64),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/logo.svg'),
              const SizedBox(width: 10),
              const Text(
                'SoundCrowd',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100,
              color: Colors.transparent,
              child: const SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.home_outlined, size: 36),
                title: const Center(
                    child: Text('Home', style: TextStyle(fontSize: 28))),
                onTap: () {
                  // Handle the tap
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.search_outlined, size: 36),
                title: const Center(
                    child: Text('Search', style: TextStyle(fontSize: 28))),
                onTap: () {
                  // Handle the tap
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.grid_view_outlined, size: 36),
                title: const Center(
                    child: Text('Your Events', style: TextStyle(fontSize: 28))),
                onTap: () {
                  // Handle the tap
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.account_circle_outlined, size: 36),
                title: const Center(
                    child:
                        Text('Your Profile', style: TextStyle(fontSize: 28))),
                onTap: () {
                  // Handle the tap
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.settings_outlined, size: 36),
                title: const Center(
                    child: Text('Settings', style: TextStyle(fontSize: 28))),
                onTap: () {
                  // Handle the tap
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.queue_music_outlined, size: 36),
                title: const Center(
                    child:
                        Text('Your Playlists', style: TextStyle(fontSize: 28))),
                onTap: () {
                  // Handle the tap
                },
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color(0xff000000),
              Color(0xff051e0f),
              Color(0xff083216),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: const SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 40, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Playlists",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      RecentCard(),
                      SizedBox(width: 20),
                      RecentCard(),
                      SizedBox(width: 20),
                      RecentCard(),
                      SizedBox(width: 20),
                      RecentCard(),
                      SizedBox(width: 20),
                      RecentCard(),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  "Your Favourites",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 15),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SongWidget(),
                        SizedBox(height: 20),
                        SongWidget(),
                        SizedBox(height: 20),
                        SongWidget(),
                        SizedBox(height: 20),
                        SongWidget(),
                        SizedBox(height: 20),
                        SongWidget(),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                NowPlaying(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
