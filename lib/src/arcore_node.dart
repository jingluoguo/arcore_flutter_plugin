import 'package:arcore_flutter_plugin/src/arcore_image.dart';
import 'package:arcore_flutter_plugin/src/shape/arcore_shape.dart';
import 'package:arcore_flutter_plugin/src/utils/random_string.dart'
    as random_string;
import 'package:arcore_flutter_plugin/src/utils/vector_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart';

class ArCoreNode {
  ArCoreNode({
    this.shape,
    this.image,
    this.xAngle,
    this.isShadowCaster = true,
    String? name,
    Vector3? position,
    Vector3? scale,
    Vector4? rotation,

    this.listen = false,
    this.children = const [],
  })  : name = name ?? random_string.randomString(),
        position = position != null ? ValueNotifier(position) : null,
        scale = scale != null ? ValueNotifier(scale) : null,
        rotation = rotation != null ? ValueNotifier(rotation) : null,
        assert(!(shape != null && image != null));

  final List<ArCoreNode>? children;

  final ArCoreShape? shape;

  /// true：只监听父级，根据name进行监听
  final bool? listen;

  final ValueNotifier<Vector3>? position;

  final ValueNotifier<Vector3>? scale;

  final ValueNotifier<Vector4>? rotation;

  /// 自定义anchor翻转角度，围绕X轴，值为空则使用rotation
  final double? xAngle;

  /// 是否保留阴影，默认true
  final bool isShadowCaster;

  final String? name;

  final ArCoreImage? image;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'dartType': runtimeType.toString(),
        'shape': shape?.toMap(),
        'position': convertVector3ToMap(position?.value),
        'scale': convertVector3ToMap(scale?.value),
        'rotation': convertVector4ToMap(rotation?.value),
        'xAngle': xAngle,
        'isShadowCaster': isShadowCaster,
        'name': name,
        'image': image?.toMap(),
        'listen': listen,
        'children':
            this.children?.map((arCoreNode) => arCoreNode.toMap()).toList(),
      }..removeWhere((String k, dynamic v) => v == null);
}
