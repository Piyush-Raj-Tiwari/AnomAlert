import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

class MjpegPlayer extends HookWidget {
  MjpegPlayer(this.streamUrl, this.token,{super.key});
  final String streamUrl;
  final String token;
  @override
  Widget build(BuildContext context) {
    final isRunning = useState(true);
    return Center(
      child: Mjpeg(
        isLive: isRunning.value,
        error: (context, error, stack) {
          print(error);
          print(stack);
          return Text(error.toString(), style: TextStyle(color: Colors.red));
        },
        stream:
        'http://uk.jokkmokk.jp/photo/nr4/latest.jpg',
        //    streamUrl,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },//'http://192.168.1.37:8081',
      ),
    );
  }
}
