import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:tensorflow/image_segmentation/helper/isolate_inference.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:isolate';

class ImageSegmentationHelper {
  late Interpreter _interpreter;
  late List<String> _labels;
  late IsolateInference _isolateInference;
  late List<int> _inputShape;
  late List<int> _outputShape;

  static final labelColors = [
    -16777216,
    -8388608,
    -16744448,
    -8355840,
    -16777088,
    -8388480,
    -16744320,
    -8355712,
    -12582912,
    -4194304,
    -12550144,
    -4161536,
    -12582784,
    -4194176,
    -12550016,
    -4161408,
    -16760832,
    -8372224,
    -16728064,
    -8339456,
    -16760704
  ];

  _loadModel() async {
    final options = InterpreterOptions();
    _interpreter = await Interpreter.fromAsset('assets/deeplabv3.tflite',
        options: options);
  }

  _loadLabel() async {
    final labelString = await rootBundle.loadString('assets/labelmap.txt');
    _labels = labelString.split('\n');
  }

  Future<void> initHelper() async {
    await _loadModel();
    await _loadLabel();
    _inputShape = _interpreter.getInputTensor(0).shape;
    _outputShape = _interpreter.getOutputTensor(0).shape;
    _isolateInference = IsolateInference();
    await _isolateInference.start();
  }

  Future<List<List<List<double>>>?> inferenceCameraFrame(
      CameraImage cameraImage) async {
    final inferenceModel = InferenceModel(
        cameraImage, _interpreter.address, _inputShape, _outputShape);
    ReceivePort responsePort = ReceivePort();
    _isolateInference.sendPort
        .send(inferenceModel..responsePort = responsePort.sendPort);
    final results = await responsePort.first;
    return results;
  }

  getLabelsName(int index) {
    return _labels[index];
  }

  close() {
    _interpreter.close();
  }
}