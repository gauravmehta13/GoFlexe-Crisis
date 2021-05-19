import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class EnglishVideos extends StatefulWidget {
  @override
  _EnglishVideosState createState() => _EnglishVideosState();
}

class _EnglishVideosState extends State<EnglishVideos> {
  List<YoutubePlayerController> controllers = [];
  List videos = [
    'CJzo6JIqhCw',
  ];
  void initState() {
    super.initState();
    getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 10),
        itemCount: controllers.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: YoutubePlayerIFrame(
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                  new Factory<OneSequenceGestureRecognizer>(
                    () => new TapGestureRecognizer(),
                  ),
                ].toSet(),
                controller: controllers[index],
                aspectRatio: 16 / 9,
              ),
            ),
          );
        });
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
