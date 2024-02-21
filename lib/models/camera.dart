import 'package:flutter/cupertino.dart';

import 'recording.dart';

class Camera {
  final String name;
  final String rtspUrl;
  final bool isTurnedOn;
  final List<Recording> recordings;
  final String? id;

  Camera({required this.name, required this.rtspUrl, this.isTurnedOn = false, this.id, this.recordings = const []});

  factory Camera.fromJson(Map<String, dynamic>json) {
    print(json);
    return switch (json) {
      {
        'camera_name': String name,
        'rtsp_url': String rtspUrl,
        '_id': "k",
        'current_status' : bool isTurnedOn,
        'recordings': [],
      } =>
        Camera(
          name: name,
          rtspUrl: rtspUrl,
          isTurnedOn: isTurnedOn,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
