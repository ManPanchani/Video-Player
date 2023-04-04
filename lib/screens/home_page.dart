import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late YoutubePlayerController youtubePlayerController;
  late YoutubePlayerController youtubePlayerController1;
  late YoutubePlayerController youtubePlayerController2;
  late YoutubePlayerController youtubePlayerController3;
  bool isPlayerReady = false;

  late PlayerState playerState;
  late YoutubeMetaData videoMetaData;

  final List<String> videos = [
    'n_FCrCQ6-bA',
    'y-PQiShdTKA',
    'GgmFC8y8q3k',
    'M8vDwlHigJA',
  ];

  final List<String> hindi = [
    'VuG7ge_8I2Y',
    'sAzlWScHTc4',
    'hp_-RlwNg04',
    'YxWlaYCA8MU',
  ];

  final List<String> ariJit = [
    'NqolrXstoA8',
    'ElZfdU54Cp8',
    'FJ55SHCzt88',
    'WjAPDofGg28',
  ];

  final List<String> songs = [
    'nzt5emj3zxA',
    'kQxyjfYA94w',
    '1Kc63GO55Nk',
    '0oDL-38BooM',
    'y-7cVpeLyx4',
  ];

  @override
  void initState() {
    super.initState();
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: videos.first,
      flags: const YoutubePlayerFlags(
        showLiveFullscreenButton: false,
        autoPlay: false,
        forceHD: true,
      ),
    )..addListener(listener);

    youtubePlayerController1 = YoutubePlayerController(
      initialVideoId: hindi.first,
      flags: const YoutubePlayerFlags(
        showLiveFullscreenButton: false,
        autoPlay: false,
        forceHD: true,
      ),
    )..addListener(listener);

    youtubePlayerController2 = YoutubePlayerController(
      initialVideoId: ariJit.first,
      flags: const YoutubePlayerFlags(
        showLiveFullscreenButton: false,
        autoPlay: false,
        forceHD: true,
      ),
    )..addListener(listener);

    youtubePlayerController3 = YoutubePlayerController(
      initialVideoId: songs.first,
      flags: const YoutubePlayerFlags(
        showLiveFullscreenButton: false,
        autoPlay: false,
        forceHD: true,
      ),
    )..addListener(listener);
  }

  void listener() {
    if (isPlayerReady && !youtubePlayerController.value.isFullScreen) {
      setState(() {
        playerState = youtubePlayerController.value.playerState;
        videoMetaData = youtubePlayerController.metadata;
      });
    }
  }

  @override
  void deactivate() {
    youtubePlayerController.pause();
    youtubePlayerController1.pause();
    youtubePlayerController2.pause();
    youtubePlayerController3.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    youtubePlayerController.dispose();
    youtubePlayerController1.dispose();
    youtubePlayerController2.dispose();
    youtubePlayerController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Player"),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.grid_view_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                elevation: 3,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Songs",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    YoutubePlayerBuilder(
                      player: YoutubePlayer(
                        showVideoProgressIndicator: true,
                        controller: youtubePlayerController3,
                        onReady: () {
                          isPlayerReady = true;
                        },
                        onEnded: (data) {
                          youtubePlayerController3.load(
                            songs[(songs.indexOf(data.videoId) + 1) %
                                songs.length],
                          );
                        },
                      ),
                      builder: (context, player) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            player,
                          ],
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.skip_previous),
                          onPressed: isPlayerReady
                              ? () => youtubePlayerController3.load(songs[
                                  (songs.indexOf(youtubePlayerController3
                                              .metadata.videoId) -
                                          1) %
                                      songs.length])
                              : null,
                        ),
                        IconButton(
                          icon: Icon(
                            youtubePlayerController3.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                          onPressed: isPlayerReady
                              ? () {
                                  youtubePlayerController3.value.isPlaying
                                      ? youtubePlayerController3.pause()
                                      : youtubePlayerController3.play();
                                  setState(() {});
                                }
                              : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.skip_next),
                          onPressed: isPlayerReady
                              ? () => youtubePlayerController3.load(
                                    songs[(songs.indexOf(
                                                youtubePlayerController3
                                                    .metadata.videoId) +
                                            1) %
                                        songs.length],
                                  )
                              : null,
                        ),
                        FullScreenButton(
                          controller: youtubePlayerController3,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                elevation: 3,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Sidhu Moose Wala Song",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    YoutubePlayerBuilder(
                      player: YoutubePlayer(
                        showVideoProgressIndicator: true,
                        controller: youtubePlayerController,
                        onReady: () {
                          isPlayerReady = true;
                        },
                        onEnded: (data) {
                          youtubePlayerController.load(
                            videos[(videos.indexOf(data.videoId) + 1) %
                                videos.length],
                          );
                        },
                      ),
                      builder: (context, player) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            player,
                          ],
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.skip_previous),
                          onPressed: isPlayerReady
                              ? () => youtubePlayerController.load(videos[
                                  (videos.indexOf(youtubePlayerController
                                              .metadata.videoId) -
                                          1) %
                                      videos.length])
                              : null,
                        ),
                        IconButton(
                          icon: Icon(
                            youtubePlayerController.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                          onPressed: isPlayerReady
                              ? () {
                                  youtubePlayerController.value.isPlaying
                                      ? youtubePlayerController.pause()
                                      : youtubePlayerController.play();
                                  setState(() {});
                                }
                              : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.skip_next),
                          onPressed: isPlayerReady
                              ? () => youtubePlayerController.load(
                                    videos[(videos.indexOf(
                                                youtubePlayerController
                                                    .metadata.videoId) +
                                            1) %
                                        videos.length],
                                  )
                              : null,
                        ),
                        FullScreenButton(
                          controller: youtubePlayerController,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                elevation: 3,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Hindi Song",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    YoutubePlayerBuilder(
                      player: YoutubePlayer(
                        showVideoProgressIndicator: true,
                        controller: youtubePlayerController1,
                        onReady: () {
                          isPlayerReady = true;
                        },
                        onEnded: (data) {
                          youtubePlayerController1.load(
                            hindi[(hindi.indexOf(data.videoId) + 1) %
                                hindi.length],
                          );
                        },
                      ),
                      builder: (context, player) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            player,
                          ],
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.skip_previous),
                          onPressed: isPlayerReady
                              ? () => youtubePlayerController1.load(hindi[
                                  (hindi.indexOf(youtubePlayerController1
                                              .metadata.videoId) -
                                          1) %
                                      hindi.length])
                              : null,
                        ),
                        IconButton(
                          icon: Icon(
                            youtubePlayerController1.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                          onPressed: isPlayerReady
                              ? () {
                                  youtubePlayerController1.value.isPlaying
                                      ? youtubePlayerController1.pause()
                                      : youtubePlayerController1.play();
                                  setState(() {});
                                }
                              : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.skip_next),
                          onPressed: isPlayerReady
                              ? () => youtubePlayerController1.load(
                                    hindi[(hindi.indexOf(
                                                youtubePlayerController1
                                                    .metadata.videoId) +
                                            1) %
                                        hindi.length],
                                  )
                              : null,
                        ),
                        FullScreenButton(
                          controller: youtubePlayerController1,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "AriJit Song",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    YoutubePlayerBuilder(
                      player: YoutubePlayer(
                        showVideoProgressIndicator: true,
                        controller: youtubePlayerController2,
                        onReady: () {
                          isPlayerReady = true;
                        },
                        onEnded: (data) {
                          youtubePlayerController2.load(
                            ariJit[(ariJit.indexOf(data.videoId) + 1) %
                                ariJit.length],
                          );
                        },
                      ),
                      builder: (context, player) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            player,
                          ],
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.skip_previous),
                          onPressed: isPlayerReady
                              ? () => youtubePlayerController2.load(ariJit[
                                  (ariJit.indexOf(youtubePlayerController2
                                              .metadata.videoId) -
                                          1) %
                                      ariJit.length])
                              : null,
                        ),
                        IconButton(
                          icon: Icon(
                            youtubePlayerController2.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                          onPressed: isPlayerReady
                              ? () {
                                  youtubePlayerController2.value.isPlaying
                                      ? youtubePlayerController2.pause()
                                      : youtubePlayerController2.play();
                                  setState(() {});
                                }
                              : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.skip_next),
                          onPressed: isPlayerReady
                              ? () => youtubePlayerController2.load(
                                    ariJit[(ariJit.indexOf(
                                                youtubePlayerController2
                                                    .metadata.videoId) +
                                            1) %
                                        ariJit.length],
                                  )
                              : null,
                        ),
                        FullScreenButton(
                          controller: youtubePlayerController2,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
