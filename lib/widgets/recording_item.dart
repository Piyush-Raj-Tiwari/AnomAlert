import 'package:anom_alert/providers/recordings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anom_alert/models/camera.dart';

class RecordingsItem extends ConsumerStatefulWidget {
  RecordingsItem(this.camera, {super.key});

  Camera camera;

  @override
  ConsumerState<RecordingsItem> createState() => _RecordingsItemState();
}

class _RecordingsItemState extends ConsumerState<RecordingsItem> {
  late Future<void> _recordingsFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    super.initState();
    _recordingsFuture =
        ref.read(recordingProvider.notifier).fetchRecordings(widget.camera);
  }

  @override
  Widget build(BuildContext context) {
    final allRecordings = ref.watch(recordingProvider);

    return FutureBuilder(
        future: _recordingsFuture,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: allRecordings.length,
                    itemBuilder: (ctx, index) => ListTile(
                          leading: CircleAvatar(
                            radius: 24,
                          ),
                          onTap: () {},
                          title: Text(
                            allRecordings[index].anomaly!,
                            //"Fighting"
                          ),
                          subtitle: Text(allRecordings[index].current_time!),
                        )));
  }
}
