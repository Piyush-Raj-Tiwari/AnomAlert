import 'package:anom_alert/providers/camera_provider.dart';
import 'package:anom_alert/widgets/add_camera.dart';
import 'package:anom_alert/widgets/new_camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popover/popover.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, this.token});

  final token;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  //final user = FirebaseAuth.instance.currentUser;

  void addCamera() {
    showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (ctx) {
          return const AddCamera();
        });
  }

  @override
  Widget build(BuildContext context) {
    final _myCameras = ref.watch(cameraProvider);
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: Transform.flip(
                flipX: true,
                child: Image.asset(
                  "assets/images/cctv-camera.png",
                  height: width / 2,
                  width: width / 2,
                ))),
        Text(
          "Add a camera to get started!",
          style: GoogleFonts.poppins(color: Colors.black),
        ),
      ],
    );
    if(_myCameras.isNotEmpty){
      mainContent = Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
        for(var cam in _myCameras)
          NewCamera(cam),
      ],);
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      appBar: AppBar(
        title: Text(
          "My Cameras",
          style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold),
        ),
        //backgroundColor: const Color(0xFF1E1E1E),
        actions: [
          IconButton(
              onPressed: () {
                showPopover(
                    context: context,
                    bodyBuilder: (context) {
                      return Column(
                        children: [
                          GestureDetector(
                            child: Text("Log Out"),
                          ),
                        ],
                      );
                    },
                    direction: PopoverDirection.top,
                    width: 250,
                    height: 150,
                    backgroundColor: Colors.black54);
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white70,
              ))
        ],
      ),
      body: mainContent,
      floatingActionButton: Container(
        height: 48,
        width: 48,
        child: IconButton(
          onPressed: addCamera,
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          style: IconButton.styleFrom(
              backgroundColor: Color(0xFF1E1E1E),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
        ),
      ),
    );
  }
}
