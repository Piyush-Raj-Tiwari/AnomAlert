class Recording{
  final String? video_url;
  final String? current_time;
  final String? filename;
  final String? anomaly;

  Recording({this.filename, this.current_time, this.video_url, this.anomaly});

  factory Recording.fromJson(Map<String, dynamic>json) {
    return switch (json) {
      {
      'video_url': String videoUrl,
      'current_time': String currentTime,
      'filename': String filename,

      } =>
          Recording(
            video_url: videoUrl,
            current_time: currentTime,
            filename: filename,
          ),
      _ => throw const FormatException('Failed to load recording.'),
    };
  }
}