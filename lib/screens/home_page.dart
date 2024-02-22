import 'package:anom_alert/providers/camera_provider.dart';
import 'package:anom_alert/widgets/add_camera.dart';
import 'package:anom_alert/widgets/drawer.dart';
import 'package:anom_alert/widgets/new_camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, this.token});

  final token;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  //final user = FirebaseAuth.instance.currentUser;
  late Future<void> _camerasFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _camerasFuture =
        ref.read(cameraProvider.notifier).fetchCameras(widget.token);
  }

  void addCamera(String newToken) {
    showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (ctx) {
          return AddCamera(newToken);
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
    if (_myCameras.isNotEmpty) {
      mainContent = ListView(
        children: [
          for (var cam in _myCameras) NewCamera(cam, token: widget.token,),
        ],
      );
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
      ),
      drawer: HamburgerMenu(),
      body: FutureBuilder(
          future: _camerasFuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : mainContent),
      floatingActionButton: Container(
        height: 48,
        width: 48,
        child: IconButton(
          onPressed: () {
            addCamera(widget.token);
          },
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
