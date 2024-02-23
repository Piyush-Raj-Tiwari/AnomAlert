import 'dart:convert';

import 'package:anom_alert/models/camera.dart';
import 'package:anom_alert/models/recording.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'camera_provider.dart';

class RecordingsNotifier extends StateNotifier<List<Recording>> {
  RecordingsNotifier() : super([]);

  Future<void> fetchRecordings(Camera selectedCamera) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final token = preferences.getString("token");

    if (token == null) {
      print("no token");
      return;
    }
    //print("$baseUrl/recording/get_recordings?id=${selectedCamera.id!}");
    final response = await http.get(
      Uri.parse("$baseUrl/recording/get_recordings?id=${selectedCamera.id!}"),

      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      List<Recording>finalRecordings = [];
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final recordings = jsonDecode(response.body)["recordings"];
      for (var savedRecordings in recordings) {
        Recording newRecording = Recording(
            video_url: savedRecordings["video_url"],
            filename: savedRecordings["filename"],
        anomaly: savedRecordings["anomaly"],
        current_time: savedRecordings["current_time"]);
        finalRecordings.add(newRecording);
      }
      state = finalRecordings;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load camera');
    }
  }
}

final recordingProvider =
    StateNotifierProvider<RecordingsNotifier, List<Recording>>(
        (ref) => RecordingsNotifier());
