// The code in this file is adapted from Oleksandr Leuschenko' ARKit Flutter Plugin (https://github.com/olexale/arkit_flutter_plugin)
import 'package:json_annotation/json_annotation.dart';
import 'package:vector_math/vector_math_64.dart';

class MatrixConverter implements JsonConverter<Matrix4, List<dynamic>> {
  const MatrixConverter();

  @override
  Matrix4 fromJson(List<dynamic> json) {
    return Matrix4.fromList(json.cast<double>());
  }

  @override
  List<dynamic> toJson(Matrix4 matrix) {
    final list = List<double>.filled(16, 0.0);
    matrix.copyIntoArray(list);
    return list;
  }
}

class Vector3Converter implements JsonConverter<Vector3, List<dynamic>> {
  const Vector3Converter();

  @override
  Vector3 fromJson(List<dynamic> json) {
    return Vector3(json[0], json[1], json[2]);
  }

  @override
  List<dynamic> toJson(Vector3 object) {
    final list = List.filled(3, 0.0);
    object.copyIntoArray(list);
    return list;
  }
}


