import 'dart:convert';

import 'package:anom_alert/providers/camera_provider.dart';
import 'package:anom_alert/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:anom_alert/models/camera.dart';
import 'package:http/http.dart' as http;

class CameraDetailsScreen extends StatefulWidget {
  const CameraDetailsScreen(this.selectedCamera,
      {required this.token, super.key});

  final Camera selectedCamera;
  final String token;

  @override
  State<CameraDetailsScreen> createState() => _CameraDetailsScreenState();
}

class _CameraDetailsScreenState extends State<CameraDetailsScreen> {

  void editCameraName(String newCameraName) async {
    final response = await http.patch(
        Uri.parse("$baseUrl/camera/update_camera_name"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${widget.token}'
        },
        body: jsonEncode(<String, String>{
          'camera_id': widget.selectedCamera.id!,
          'new_camera_name': newCameraName
        }));

  }

  void deleteCamera() async {
    print("hi");
    final response = await http.delete(
      Uri.parse("$baseUrl/camera/delete_camera"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${widget.token}'
      },
      body: jsonEncode(<String, String>{'camera_id': widget.selectedCamera.id!}),
    );
    print(response.body);
    if(response.statusCode==200){
      Navigator.of(context).pop("delete");
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (item) => (item) {
              switch (item) {
                case 0: //editCameraName(newCameraName)
                  break;
                case 1:
                  deleteCamera();
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<int>(value: 0, child: Text('Edit Camera Name')),
              PopupMenuItem<int>(value: 1, child: Text('Delete Camera'), onTap: deleteCamera,),
            ],
          ),
        ],
        title: Text(
          widget.selectedCamera.name,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: VideoPlayerScreen(
                widget.selectedCamera,
                token: widget.token,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
