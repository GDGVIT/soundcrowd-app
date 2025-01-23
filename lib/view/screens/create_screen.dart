import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_collab_app/providers/create_screen_provider.dart';
import 'package:spotify_collab_app/view/widgets/custom_text_field.dart';
import 'package:spotify_collab_app/providers/photo_upload_notifier.dart';

class CreateScreen extends ConsumerStatefulWidget {
  const CreateScreen({super.key});

  @override
  CreateScreenState createState() => CreateScreenState();
}

class CreateScreenState extends ConsumerState<CreateScreen> {
  final TextEditingController eventNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    final createState = ref.watch(createScreenProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SvgPicture.asset(
              'assets/bg.svg',
              colorFilter:
                  const ColorFilter.mode(Color(0xffd1dfdb), BlendMode.srcIn),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.06,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.go('/home');
                        ref.read(photoUploadProvider.notifier).clearImage();
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                      color: const Color(0xff5822EE),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'New Shared Playlist',
                        style: TextStyle(
                          fontFamily: 'Gotham',
                          shadows: <Shadow>[
                            Shadow(
                              color: Color(0xffDA84FE),
                              offset: Offset(0, 2),
                            ),
                          ],
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            ref.read(photoUploadProvider.notifier).pickImage();
                          },
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: width * 0.15,
                                backgroundImage: ref
                                            .watch(photoUploadProvider) !=
                                        null
                                    ? FileImage(ref.watch(photoUploadProvider)!)
                                    : null,
                                child: ref.watch(photoUploadProvider) == null
                                    ? const Text(
                                        'Upload\n Photo',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      )
                                    : null,
                              ),
                              Positioned(
                                top: height * 0.1,
                                bottom: 0,
                                child: SvgPicture.asset(
                                  'assets/plus.svg',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.055,
                      ),
                      CustomTextField(
                        labelText: 'Event name',
                        obscureText: false,
                        textEditingController: eventNameController,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all(
                              const Color(0xff5822EE),
                            ),
                          ),
                          onPressed: createState.isLoading
                              ? null
                              : () async {
                                  if (eventNameController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Event name cannot be empty',
                                          style: TextStyle(
                                            fontFamily: 'Gotham',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return;
                                  }

                                  final image = ref.watch(photoUploadProvider);

                                  final result = await ref
                                      .read(createScreenProvider.notifier)
                                      .createPlaylist(
                                        eventNameController.text,
                                        image: image,
                                      );

                                  if (!context.mounted) return;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        result.message,
                                        style: const TextStyle(
                                          fontFamily: 'Gotham',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      backgroundColor: result.success
                                          ? Colors.green
                                          : Colors.red.withOpacity(0.8),
                                    ),
                                  );

                                  if (result.success) {
                                    context.go('/home');
                                    ref
                                        .read(photoUploadProvider.notifier)
                                        .clearImage();
                                  }
                                },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 5),
                            child: createState.isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Create event',
                                    style: TextStyle(
                                      fontFamily: 'Gotham',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
