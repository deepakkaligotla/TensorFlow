import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tensorflow/gesture_classification/helper/gesture_classification_helper.dart';
import 'package:tensorflow/main.dart';


class GestureClassificationApp extends StatelessWidget {
  const GestureClassificationApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gesture classification',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MyHomePage(
          title:
              'An end-to-end example of gesture classification using Flutter and TensorFlow Lite'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  CameraController? _cameraController;
  late GestureClassificationHelper _gestureClassificationHelper;
  Map<String, double>? _classification;
  bool _isProcessing = false;
  late CameraDescription _cameraDescription;

  // init camera
  _initCamera() {
    _cameraDescription = cameras.firstWhere(
        (element) => element.lensDirection == CameraLensDirection.front);
    _cameraController = CameraController(
        _cameraDescription, ResolutionPreset.high,
        imageFormatGroup: Platform.isIOS
            ? ImageFormatGroup.bgra8888
            : ImageFormatGroup.yuv420);
    _cameraController!.initialize().then((value) {
      _cameraController!.startImageStream(_imageAnalysis);
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<void> _imageAnalysis(CameraImage cameraImage) async {
    // if image is still analyze, skip this frame
    if (_isProcessing) {
      return;
    }
    _isProcessing = true;
    _classification =
        await _gestureClassificationHelper.inferenceCameraFrame(cameraImage);
    _isProcessing = false;
    if (mounted) {
      setState(() {});
    }
  }

  // this function using config camera and init model
  _initHelper() {
    _initCamera();
    _gestureClassificationHelper = GestureClassificationHelper();
    _gestureClassificationHelper.init();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initHelper();
    });
  }

  // handle app lifecycle state change (pause/resume)
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        _cameraController?.stopImageStream();
        break;
      case AppLifecycleState.resumed:
        if (_cameraController != null &&
            !_cameraController!.value.isStreamingImages) {
          await _cameraController!.startImageStream(_imageAnalysis);
        }
        break;
      default:
    }
  }

  // dispose camera
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    _gestureClassificationHelper.close();
    super.dispose();
  }

  Widget cameraWidget(context) {
    if (_cameraController == null) return Container();

    // get current camera preview size
    var camera = _cameraController!.value;
    // fetch screen size
    final size = MediaQuery.of(context).size;

    // calculate scale depending on screen and camera ratios
    // this is actually size.aspectRatio / (1 / camera.aspectRatio)
    // because camera preview size is received as landscape
    // but we're calculating for portrait orientation
    var scale = size.aspectRatio * camera.aspectRatio;

    // to prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;

    return Transform.scale(
      scale: scale,
      child: Center(
        child: CameraPreview(_cameraController!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset('assets/images/tfl_logo.png'),
        ),
        backgroundColor: Colors.black.withOpacity(0.5),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Stack(
        children: [
          SizedBox(
            child: cameraWidget(context),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (_classification != null)
                    ...(_classification!.entries.toList()
                          ..sort(
                            (a, b) => a.value.compareTo(b.value),
                          ))
                        .reversed
                        .take(3)
                        .map(
                          (e) => Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.white,
                            child: Row(
                              children: [
                                Text(e.key),
                                const Spacer(),
                                Text(e.value.toStringAsFixed(2))
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}