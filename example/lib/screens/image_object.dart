import 'dart:math';

import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ImageObjectScreen extends StatefulWidget {
  final Uint8List bytes;
  const ImageObjectScreen({Key? key, required this.bytes}) : super(key: key);
  @override
  _ImageObjectScreenState createState() => _ImageObjectScreenState();
}

class _ImageObjectScreenState extends State<ImageObjectScreen> {
  ArCoreController? arCoreController;

  Matrix4 transform = Matrix4.identity();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Image object'),
        ),
        body: Stack(
          children: [
            ArCoreView(
              onArCoreViewCreated: _onArCoreViewCreated,
              enableTapRecognizer: true,
              enableUpdateListener: true,
              planeDetectionConfig: PlaneDetectionConfig.horizontal,
              customPlaneTexturePath: "assets/triangle.png",
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () async {
                    arCoreController?.snapshot();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.red,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController?.onPlaneTap = _handleOnPlaneTap;
    arCoreController?.onPlaneDetected = _handleOnPlaneDetected;
    arCoreController?.onNodeUpdate = _handleOnNodeUpdate;
  }

  ArCoreNode? _now;

  Future _addImage(ArCoreHitTestResult hit) async {
    await arCoreController?.removeNode(nodeName: "xxxx");
    _now = null;

    vector.Vector4 originalVector = hit.pose.rotation;

    vector.Vector4 test = vector.Vector4(
      originalVector.x,
      originalVector.y,
      originalVector.z,
      originalVector.w,
    );

    _now = ArCoreNode(
      name: "test",
      listen: true,
      image: ArCoreImage(bytes: widget.bytes, width: 300, height: 300),
      position: hit.pose.translation + vector.Vector3(0, 0, 0),
      rotation: test,
      scale: vector.Vector3(0.3, 0.3, 0.3)
    );

    arCoreController?.addArCoreNodeWithAnchor(_now!);

    /// 显示或隐藏平面点
    await arCoreController?.togglePlaneRenderer();

  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    _addImage(hit);
  }

  ArCorePlane? plane;
  void _handleOnPlaneDetected(ArCorePlane arCorePlane) {
    plane = arCorePlane;
  }

  void _handleOnNodeUpdate(name, Matrix4 transform) {
    print("这里是啥？${transform.storage}  xxxx: $transform");
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}
