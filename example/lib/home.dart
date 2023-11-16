import 'package:arcore_flutter_plugin_example/screens/augmented_faces.dart';
import 'package:arcore_flutter_plugin_example/screens/augmented_images.dart';
import 'package:arcore_flutter_plugin_example/screens/image_object.dart';
import 'package:arcore_flutter_plugin_example/screens/matri_3d.dart';
import 'package:arcore_flutter_plugin_example/screens/multiple_augmented_images.dart';
import 'package:flutter/material.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'screens/hello_world.dart';
import 'screens/custom_object.dart';
import 'screens/runtime_materials.dart';
import 'screens/texture_and_rotation.dart';
import 'screens/assets_object.dart';
import 'screens/auto_detect_plane.dart';
import 'screens/remote_object.dart';

class HomeScreen extends StatelessWidget {

  final WidgetsToImageController _controller = WidgetsToImageController();

  // final GlobalKey _globalKey = GlobalKey();
  //
  // Future<Uint8List> widgetToImage() async {
  //   Completer<Uint8List> completer = Completer();
  //
  //   RenderRepaintBoundary render = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //   ui.Image image = await render.toImage(pixelRatio: 20);
  //   ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //   completer.complete(byteData?.buffer.asUint8List());
  //
  //   return completer.future;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ArCore Demo'),
      ),
      body: Stack(
        children: [
          WidgetsToImage(
            controller: _controller,
            child: Container(
              height: 100,
              width: 100,
              color: Colors.blue,
              child: Text("xxxxxx这里是测试数据", style: TextStyle(color: Colors.red), textAlign: TextAlign.center),
            ),
          ),
          ListView(
            children: <Widget>[
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => HelloWorld()));
                },
                title: Text("Hello World"),
              ),
              ListTile(
                onTap: () async {

                  // var datas = await widgetToImage();
                  var data = await _controller.capture();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ImageObjectScreen(bytes: data!)));
                },
                title: Text("Image"),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AugmentedPage()));
                },
                title: Text("AugmentedPage"),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MultipleAugmentedImagesPage()));
                },
                title: Text("Multiple augmented images"),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CustomObject()));
                },
                title: Text("Custom Anchored Object with onTap"),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RuntimeMaterials()));
                },
                title: Text("Change Materials Property in runtime"),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ObjectWithTextureAndRotation()));
                },
                title: Text("Custom object with texture and rotation listener "),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AutoDetectPlane()));
                },
                title: Text("Plane detect handler"),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Matrix3DRenderingPage()));
                },
                title: Text("3D Matrix"),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AssetsObject()));
                },
                title: Text("Custom sfb object"),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RemoteObject()));
                },
                title: Text("Remote object"),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AugmentedFacesScreen()));
                },
                title: Text("Augmented Faces"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
