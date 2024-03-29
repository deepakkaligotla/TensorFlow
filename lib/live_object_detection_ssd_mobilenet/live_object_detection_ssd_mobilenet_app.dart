import 'package:flutter/material.dart';
import 'package:tensorflow/live_object_detection_ssd_mobilenet/models/screen_params.dart';
import 'package:tensorflow/live_object_detection_ssd_mobilenet/ui/detector_widget.dart';

/// [HomeView] stacks [DetectorWidget]
class LiveObjectDetectionSSDMobileNetApp extends StatelessWidget {
  const LiveObjectDetectionSSDMobileNetApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenParams.screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      key: GlobalKey(),
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/tfl_logo.png',
          fit: BoxFit.contain,
        ),
      ),
      body: const DetectorWidget(),
    );
  }
}