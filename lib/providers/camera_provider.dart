import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:anom_alert/models/camera.dart';

final List<Camera> cameras = [];

class CameraNotifier extends StateNotifier<List<Camera>> {
  CameraNotifier() : super(cameras);

  void addCamera(String name, String rstpUrl) async {
    final newCamera = Camera(name: name, rstpUrl: rstpUrl);
    state = [newCamera, ...state];
  }
}

final cameraProvider = StateNotifierProvider<CameraNotifier, List<Camera>>(
    (ref) => CameraNotifier());
