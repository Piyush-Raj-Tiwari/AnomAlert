import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:anom_alert/models/camera.dart';

final baseUrl = "http://43.204.148.194:5111";

class CameraNotifier extends StateNotifier<List<Camera>> {
  CameraNotifier() : super([]);

  void addCamera(String name, String rtspUrl, String? token) async {
    if (token == null) {
      print("no token");
      return;
    }

    final response = await http.post(
      Uri.parse("$baseUrl/camera/addCamera"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{'camera_name': name, 'rtsp': rtspUrl}),
    );
    final cameraId = jsonDecode(response.body)["camera"]["_id"];
    final newCamera = Camera(name: name, rtspUrl: rtspUrl, id: cameraId);
    print(newCamera);
    state = [newCamera, ...state];
  }

  Future<void> fetchCameras(String? token) async {
    if (token == null) {
      print("no token");
      return;
    }
    //print(token);
    final response = await http.get(
      Uri.parse("$baseUrl/camera/camera_list"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      List<Camera> finalCameraList = [];
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final camerasList = jsonDecode(response.body)["camera_list"];
      for (var cameraData in camerasList) {
        Camera camera = Camera(
          name: cameraData["camera_name"],
          rtspUrl: cameraData["rtsp_url"],
          id: cameraData["_id"]
        );
        finalCameraList.add(camera);
      }
      print(camerasList);
      state = finalCameraList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load cameras');
    }
    print(response.body);
  }
}

final cameraProvider = StateNotifierProvider<CameraNotifier, List<Camera>>(
    (ref) => CameraNotifier());
