import 'package:anom_alert/providers/camera_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddCamera extends ConsumerWidget {
  const AddCamera({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _cameraName = "";
    var _rstpCode = "";
    final _formKey = GlobalKey<FormState>();

    void _createNewCamera() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ref.read(cameraProvider.notifier).addCamera(_cameraName, _rstpCode);
      }
    }

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Camera",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                style: const TextStyle(color: Color(0xFF515D6B)),
                decoration: InputDecoration(
                  label: const Text("Camera Name"),
                  hintText: "Eg: Main Gate CCTV",
                  hintStyle: GoogleFonts.inter(fontSize: 16),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name must not be empty";
                  }
                  return null;
                },
                onSaved: (value) {
                  _cameraName = value!;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                style: const TextStyle(color: Color(0xFF515D6B)),
                decoration: InputDecoration(
                  label: const Text("RTSP URL"),
                  hintText: "Enter RTSP URL of your camera",
                  hintStyle: GoogleFonts.inter(fontSize: 16),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a valid RTSP code";
                  }
                  return null;
                },
                onSaved: (value) {
                  _rstpCode = value!;
                },
              ),
              const SizedBox(
                height: 36,
              ),
              ElevatedButton(
                  onPressed: _createNewCamera,
                  child: Text(
                    "Add Camera",
                    style: GoogleFonts.urbanist(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  )),
            ],
          ),
        ),
      );
    });
  }
}
