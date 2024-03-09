import 'dart:isolate';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'isolate_inference.dart';

class GestureClassificationHelper {
  static const _modelPath = 'assets/gesture_classification.tflite';
  static const _labelsPath = 'assets/labels.txt';
  late final List<String> _labels;
  late Interpreter _interpreter;
  late final IsolateInference _isolateInference;
  late Tensor _inputTensor;
  late Tensor _outputTensor;

  void _loadModel() async {
    final options = InterpreterOptions();
    // Load model from assets
    _interpreter = await Interpreter.fromAsset(_modelPath, options: options);
    _inputTensor = _interpreter.getInputTensors().first;
    _outputTensor = _interpreter.getOutputTensors().first;
  }

  // load model and labels
  Future<void> init() async {
    _loadModel();
    _loadLabels();
    _isolateInference = IsolateInference();
    await _isolateInference.start();
  }

  Future<void> _loadLabels() async {
    final labelTxt = await rootBundle.loadString(_labelsPath);
    _labels = labelTxt.split(',');
  }

  // inference classification model in separate isolate
  Future<Map<String, double>> _inference(InferenceModel inferenceModel) async {
    ReceivePort responsePort = ReceivePort();
    _isolateInference.sendPort
        .send(inferenceModel..responsePort = responsePort.sendPort);
    // get inference result.
    var results = await responsePort.first;
    return results;
  }

  // inference camera frame
  Future<Map<String, double>> inferenceCameraFrame(
      CameraImage cameraImage) async {
    var isolateModel = InferenceModel(cameraImage, _interpreter.address,
        _labels, _inputTensor.shape, _outputTensor.shape);
    return _inference(isolateModel);
  }

  Future<void> close() async {
    await _isolateInference.close();
    _interpreter.close();
  }
}