package com.difrancescogianmarco.arcore_flutter_plugin.flutter_models

class FlutterArCoreHitTestResult(val distance: Float, val translation: FloatArray, val rotation: FloatArray, val matrix: FloatArray) {

    fun toHashMap(): HashMap<String, Any> {
        val map: HashMap<String, Any> = HashMap<String, Any>()
        map["distance"] = distance.toDouble()
        map["pose"] = FlutterArCorePose(translation,rotation).toHashMap()
        map["transform"] = matrix
        return map
    }
}