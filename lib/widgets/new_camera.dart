import 'package:flutter/material.dart';

import 'package:anom_alert/models/camera.dart';

class NewCamera extends StatelessWidget {
  const NewCamera(this.camera, {super.key});

  final Camera camera;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [Color(0xFF282828), Color(0xFF282828).withOpacity(0.9)],
              )),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      camera.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white),
                    ),
                    Spacer(),
                    Text(
                      "Anomaly detected",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.yellow),
                    ),
                  ],
                ),
                const Spacer(),
                Image.asset("assets/images/cctv-camera.png"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
