import 'package:flutter/material.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';

class LocationServices {
  static Future<LocationResult> showPlacePicker(context) async {
    return await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          "AIzaSyDq33g2UnBUqsMbCPvHT8imFd20IsLuel0",
        ),
      ),
    );
  }
}
