import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/home/widgets/settings_view.dart';
import 'networking.dart';

const apiKey = 'AIzaSyCZ8k5FShHO-t80iOonU3R85Jd9qDZipTM';
const url = 'https://maps.googleapis.com/maps/api/directions/json';

class TimeModel {
  String startLocation;
  String endLocation;
  BuildContext context;

  TimeModel(
      {required this.startLocation,
      required this.endLocation,
      required this.context});

  Future<int> getDepartureTime() async {
    NetworkHelper networkHelper = NetworkHelper(
        '$url?origin=$startLocation&destination=$endLocation&mode=transit&key=$apiKey');
    var timeTableData = await networkHelper.getData();
    int departureTime =
        timeTableData['routes'][0]['legs'][0]['departure_time']['value'];
    int currentTime = (DateTime.now().millisecondsSinceEpoch / 1000).round();
    int timeToDeparture = departureTime - currentTime;

    return timeToDeparture;
  }
}
