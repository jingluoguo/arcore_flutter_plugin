import 'package:arcore_flutter_plugin/src/arcore_android_view.dart';
import 'package:arcore_flutter_plugin/src/arcore_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef void ArCoreViewCreatedCallback(ArCoreController controller);

enum ArCoreViewType { AUGMENTEDFACE, STANDARDVIEW, AUGMENTEDIMAGES }

enum PlaneDetectionConfig {
  none,
  horizontal,
  vertical,
  horizontalAndVertical,
}

class ArCoreView extends StatefulWidget {
  final ArCoreViewCreatedCallback onArCoreViewCreated;

  final bool enableTapRecognizer;
  final bool enablePlaneRenderer;
  final bool enableUpdateListener;
  final PlaneDetectionConfig planeDetectionConfig;
  final bool debug;
  final bool showFeaturePoints;
  final String? customPlaneTexturePath;
  final ArCoreViewType type;

  const ArCoreView(
      {Key? key,
      required this.onArCoreViewCreated,
      this.enableTapRecognizer = false,
      this.enablePlaneRenderer = true,
      this.enableUpdateListener = false,
      this.customPlaneTexturePath,
      this.type = ArCoreViewType.STANDARDVIEW,
      this.debug = false,
      this.showFeaturePoints = false,
      this.planeDetectionConfig = PlaneDetectionConfig.horizontal})
      : super(key: key);

  @override
  _ArCoreViewState createState() => _ArCoreViewState();
}

class _ArCoreViewState extends State<ArCoreView> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return Container(
        child: ArCoreAndroidView(
          viewType: 'arcore_flutter_plugin',
          onPlatformViewCreated: _onPlatformViewCreated,
          arCoreViewType: widget.type,
          debug: widget.debug,
        ),
      );
    }
    return Center(
      child:
          Text('$defaultTargetPlatform is not supported by the ar_view plugin'),
    );
  }

  void _onPlatformViewCreated(int id) {
    widget.onArCoreViewCreated(ArCoreController(
      id: id,
      enableTapRecognizer: widget.enableTapRecognizer,
      enableUpdateListener: widget.enableUpdateListener,
      enablePlaneRenderer: widget.enablePlaneRenderer,
      planeDetectionConfig: widget.planeDetectionConfig,
      customPlaneTexturePath: widget.customPlaneTexturePath,
      showFeaturePoints: widget.showFeaturePoints
//      onUnsupported: widget.onArCoreUnsupported,
    ));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
