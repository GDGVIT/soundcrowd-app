import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_collab_app/providers/playlist_provider.dart';
import 'package:spotify_collab_app/view/widgets/custom_title.dart';
import 'package:spotify_collab_app/view/widgets/new_playlist_button.dart';
import 'package:spotify_collab_app/view/widgets/playlist_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistNotifier = ref.read(playlistProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xff111111),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const CustomTitle(
          title: "Shared Playlists",
        ),
        backgroundColor: Colors.transparent,
      ),
      body: RefreshIndicator(
        onRefresh: () => playlistNotifier.fetchPlaylists(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Create new Playlist ·",
                      style: TextStyle(
                        fontFamily: "Gotham",
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      onTap: () => context.go('/create'),
                      child: Ink(child: const NewPlaylistButton()),
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder(
                      future: playlistNotifier.fetchPlaylists(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(
                              child: Text('Failed to load playlists.'));
                        } else {
                          final playlists = ref.watch(playlistProvider);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Your Events",
                                style: TextStyle(
                                  fontFamily: "Gotham",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10),
                              if (playlists.ownedPlaylists.isEmpty)
                                const Center(
                                  child: Text(
                                    'No events. Create one!',
                                    style: TextStyle(
                                      fontFamily: "Gotham",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              else
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: playlists.ownedPlaylists.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 10,
                                  ),
                                  itemBuilder: (context, index) {
                                    return PlaylistCard(
                                      name:
                                          playlists.ownedPlaylists[index].name,
                                      id: playlists
                                          .ownedPlaylists[index].playlistUuid,
                                      imageUrl: playlists
                                          .ownedPlaylists[index].imageUrl,
                                      isActive: true,
                                      memberCount: playlists
                                          .ownedPlaylists[index].memberCount,
                                    );
                                  },
                                ),
                              const SizedBox(height: 20),
                              const Text(
                                "Joined Events",
                                style: TextStyle(
                                  fontFamily: "Gotham",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10),
                              if (playlists.memberPlaylists.isEmpty)
                                const Center(
                                  child: Text(
                                    'No events. Join one!',
                                    style: TextStyle(
                                      fontFamily: "Gotham",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              else
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: playlists.memberPlaylists.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 10,
                                  ),
                                  itemBuilder: (context, index) {
                                    return PlaylistCard(
                                      name:
                                          playlists.memberPlaylists[index].name,
                                      id: playlists
                                          .memberPlaylists[index].playlistUuid,
                                      imageUrl: playlists
                                          .memberPlaylists[index].imageUrl,
                                      memberCount: playlists
                                          .memberPlaylists[index].memberCount,
                                    );
                                  },
                                ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            IgnorePointer(
              ignoring: true,
              child: SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: SvgPicture.asset(
                  'assets/bg.svg',
                  colorFilter: const ColorFilter.mode(
                      Color(0xffd1dfdb), BlendMode.srcIn),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
