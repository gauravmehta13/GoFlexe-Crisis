import 'dart:developer';
import 'package:crisis/Widgets/Loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Videos extends StatefulWidget {
  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  List<YoutubePlayerController> controllers = [];
  List videos = ['CJzo6JIqhCw', 'OlO8sKRynBY', 'OlO8sKRynBY', 'OlO8sKRynBY'];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getVideos();
  }

  getVideos() {
    for (var i = 0; i < videos.length; i++) {
      controllers.add(YoutubePlayerController(
        initialVideoId: videos[i],
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          desktopMode: true,
          privacyEnhanced: true,
          useHybridComposition: true,
        ),
      ));
      controllers[i].onEnterFullscreen = () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
        log('Entered Fullscreen');
      };
      controllers[i].onExitFullscreen = () {
        log('Exited Fullscreen');
      };
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: loading == true
          ? Loading()
          : ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return YoutubePlayerIFrame(
                  controller: controllers[index],
                  aspectRatio: 16 / 9,
                );
              }),
    );
  }

  @override
  void dispose() {
    print("dispose");
    for (var i = 0; i < controllers.length; i++) {
      controllers[i].close();
    }
    super.dispose();
  }
}
