# Download model
curl https://storage.googleapis.com/download.tensorflow.org/models/tflite/task_library/audio_classification/flutter/lite-model_yamnet_classification_tflite_1.tflite \
    -o assets/models/yamnet.tflite

# Unzip model to get labels and vocab
unzip -o assets/models/yamnet.tflite \
    -d assets/models/

#### BertQA
# Download model
curl https://storage.googleapis.com/download.tensorflow.org/models/tflite/task_library/bert_qa/flutter/bert_qa_lite-model_mobilebert_1_metadata_1.tflite \
    -o assets/mobilebert.tflite

unzip -o assets/mobilebert.tflite \
    -d assets/

# Download QA
curl https://storage.googleapis.com/download.tensorflow.org/models/tflite/bert_qa/contents_from_squad.json \
    -o assets/qa.json

#### Digit Classification
# Download model
curl https://storage.googleapis.com/download.tensorflow.org/models/tflite/task_library/digit_classifier/flutter/mnist_metadata.tflite \
    -o assets/mnist.tflite

#### Gesture Classification
# Download model
curl https://storage.googleapis.com/download.tensorflow.org/models/tflite/task_library/gesture_classification/flutter/model_metadata.tflite \
    -o assets/gesture_classification.tflite

# Download label
curl https://storage.googleapis.com/download.tensorflow.org/models/tflite/task_library/gesture_classification/flutter/labels.txt \
    -o assets/labels.txt

#### Image Classification MobileNet
# Download model
curl https://storage.googleapis.com/download.tensorflow.org/models/tflite/task_library/image_classification/android/mobilenet_v1_1.0_224_quantized_1_metadata_1.tflite \
    -o assets/models/mobilenet_quant.tflite

# Unzip model to get labels and vocab
unzip -o assets/models/mobilenet_quant.tflite \
    -d assets/models/

#### Image Segmentation
# Download model
curl https://storage.googleapis.com/download.tensorflow.org/models/tflite/task_library/image_segmentation/flutter/lite-model_deeplabv3_1_metadata_2.tflite \
    -o assets/deeplabv3.tflite

# Unzip model to get labels
unzip -o assets/deeplabv3.tflite \
    -d assets/


#### Live Object Detection SSD MobileNet
# Download model
curl https://storage.googleapis.com/download.tensorflow.org/models/tflite/task_library/object_detection/android/lite-model_ssd_mobilenet_v1_1_metadata_2.tflite \
    -o assets/models/ssd_mobilenet.tflite

# Unzip model to get labels and vocab
unzip -o assets/models/ssd_mobilenet.tflite \
    -d assets/models/

#### Object Detection SSD MobileNet
# Download model
curl https://storage.googleapis.com/download.tensorflow.org/models/tflite/task_library/object_detection/android/lite-model_ssd_mobilenet_v1_1_metadata_2.tflite \
    -o assets/models/ssd_mobilenet.tflite

# Unzip model to get labels and vocab
unzip -o assets/models/ssd_mobilenet.tflite \
    -d assets/models/

#### Pose Estimation
# Download model
curl https://storage.googleapis.com/download.tensorflow.org/models/tflite/task_library/pose_estimation/flutter/posenet_mobilenet_v1_100_257x257_multi_kpt_stripped.tflite \
    -o assets/posenet_mobilenet.tflite

#### Reinforcement Learning
# Download model
curl https://storage.googleapis.com/download.tensorflow.org/models/tflite/flutter-plugin/reinforcement_learning/planestrike_tf.tflite \
    -o assets/models/planestrike.tflite \
    -L

#### Style Transfer
# Download models
curl https://storage.googleapis.com/download.tensorflow.org/models/tflite/task_library/style_transfer/android/magenta_arbitrary-image-stylization-v1-256_int8_prediction_1.tflite \
    -o assets/models/magenta_arbitrary-image-stylization-v1-256_int8_prediction_1.tflite

curl https://storage.googleapis.com/download.tensorflow.org/models/tflite/task_library/style_transfer/android/magenta_arbitrary-image-stylization-v1-256_int8_transfer_1.tflite \
    -o assets/models/magenta_arbitrary-image-stylization-v1-256_int8_transfer_1.tflite

#### Super Resolution Esrgan
# Download model
curl https://tfhub.dev/captain-pool/lite-model/esrgan-tf2/1?lite-format=tflite \
    -o assets/models/esrgan-tf2.tflite \
    -L

#### Text Classification
# Download model
curl https://storage.googleapis.com/download.tensorflow.org/models/tflite/text_classification/text_classification.tflite \
    -o assets/models/text_classification.tflite

# Unzip model to get labels and vocab
unzip -o assets/models/text_classification.tflite \
    -d assets/models/ \
    -x labels.txt