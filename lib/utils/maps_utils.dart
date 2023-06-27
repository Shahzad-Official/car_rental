import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsUtils {
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  Future<BitmapDescriptor> createIcon() async {
    Uint8List unit8list = await getBytesFromAsset(
      "assets/images/car_map.png",
      70,
    );
    return BitmapDescriptor.fromBytes(unit8list);
  }
}
