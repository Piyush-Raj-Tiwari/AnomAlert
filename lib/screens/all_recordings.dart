import 'package:anom_alert/widgets/recording_item.dart';
import 'package:flutter/material.dart';

class RecordingsScreen extends StatelessWidget {
  const RecordingsScreen(this.camera,{super.key});
  final camera;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      appBar: AppBar(
        title: Text("Recordings", style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),),
      ),
      body: RecordingsItem(camera),
    );
  }
}
