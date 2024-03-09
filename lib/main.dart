import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tensorflow/image_segmentation/image_segmentation_app.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TensorFlow Example',
      themeMode: MediaQuery.of(context).platformBrightness==Brightness.dark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: MediaQuery.of(context).platformBrightness==Brightness.dark ? const ColorScheme.dark() : const ColorScheme.light()
      ),
      debugShowCheckedModeBanner: false,
      home: const ImageSegmentationApp(title: 'Image Segmentation'),
    );
  }
}
