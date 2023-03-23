import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AzanScreen extends StatefulWidget {
  const AzanScreen({super.key});

  @override
  State<AzanScreen> createState() => _AzanScreenState();
}

class _AzanScreenState extends State<AzanScreen> {
  
  @override
  void initState() {
    fetchPrayerTimes();
  }

  Future<void> fetchPrayerTimes() async {
    // Get the current position of the device
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Use the device's latitude and longitude to fetch the prayer times
    final response = await http.get(Uri.parse(
        'http://api.aladhan.com/v1/calendar/${DateTime.now().year}/${DateTime.now().month}?latitude=${position.latitude}&longitude=${position.longitude}&method=2'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Extract the prayer times from the data
      final prayerTimes = data['data'][0]['timings'];
      print(prayerTimes);
    } else {
      print('Failed to fetch prayer times: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
