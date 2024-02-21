import 'package:anom_alert/providers/camera_provider.dart';
import 'package:anom_alert/screens/all_recordings.dart';
import 'package:anom_alert/widgets/mjpeg_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:anom_alert/models/camera.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen(this.camera, {required this.token, super.key});

  String token;
  final Camera camera;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  //late VideoPlayerController _controller;
  //late Future<void> _initializeVideoPlayerFuture;
  final _videoUrl = "$baseUrl/user/view?id=";

  @override
  void initState() {
    final cameraId = widget.camera.id;
    super.initState();
    final requestUrl = _videoUrl + cameraId!;
    print(requestUrl);
    print(cameraId);
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    // _controller = VideoPlayerController.networkUrl(
    //   Uri.parse(
    //     requestUrl,
    //   ),
    //   httpHeaders: {
    //     'Content-type': 'application/json',
    //     'Accept': 'application/json',
    //     'Authorization': 'Bearer ${widget.token}'
    //   },
    // )..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized
    //     setState(() {});
    //   });

    //_initializeVideoPlayerFuture = _controller.initialize();
  }

  // @override
  // void dispose() {
  //   // Ensure disposing of the VideoPlayerController to free up resources.
  //   _controller.dispose();
  //
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // Complete the code in the next step.
    final cameraId = widget.camera.id;
    final requestUrl = _videoUrl + cameraId!;
    return Column(children: [
      MjpegPlayer(requestUrl, widget.token),
      // IconButton(
      //     onPressed: () {
      //       // Wrap the play or pause in a call to `setState`. This ensures the
      //       // correct icon is shown.
      //       setState(() {
      //         // If the video is playing, pause it.
      //         if (_controller.value.isPlaying) {
      //           _controller.pause();
      //         } else {
      //           // If the video is paused, play it.
      //           _controller.play();
      //         }
      //       });
      //     },
      //     icon: Icon(
      //       _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //     )),
      const Spacer(),
      ElevatedButton(
          onPressed: () {
            final response = http.get(
                Uri.parse("$baseUrl/user/start?id=${cameraId}"),
                headers: {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer ${widget.token}'
                });
            print(response);
          },
          child: Text(
            "Start Service",
            style: GoogleFonts.urbanist(
                color: Colors.white, fontWeight: FontWeight.w500),
          )),
      const SizedBox(
        height: 16,
      ),
      OutlinedButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => RecordingsScreen(widget.camera)));
          },
          child: Text(
            "View All Recordings",
            style: GoogleFonts.urbanist(
                color: Colors.black, fontWeight: FontWeight.w500),
          )),
      const SizedBox(
        height: 24,
      )
    ]);
  }
}
