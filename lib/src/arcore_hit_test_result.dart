import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart';

import 'arcore_pose.dart';
import 'utils/json_converters.dart';

class ArCoreHitTestResult {
  late double distance;

  late Vector3 translation;

  late Vector4 rotation;

  late String nodeName;

  late ArCorePose pose;

  late Matrix4 transform;

  ArCorePlaneType? type;

  ArCoreHitTestResult.fromMap(Map<dynamic, dynamic> map) {
    this.distance = map['distance'];
    this.pose = ArCorePose.fromMap(map['pose']);
    this.transform = Matrix4.identity();
    this.type = ArCorePlaneType.values[map["type"] ?? 0];
    try {
      this.transform = MatrixConverter().fromJson(map['transform']!);
    } catch (e) {}
  }
}
