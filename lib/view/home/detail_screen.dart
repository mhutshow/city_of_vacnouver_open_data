import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vancouver_open_data/model/fountain_model.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late RecordData record;

  @override
  void initState() {
    super.initState();
    record = Get.arguments['record'];
  }

  @override
  Widget build(BuildContext context) {
    final fields = record.fields;
    return Scaffold(
      appBar: AppBar(
        title: Text(fields?.name ?? 'Detail Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Location
                  ListTile(
                    leading: Icon(Icons.location_on, color: Colors.red),
                    title: Text('Location'),
                    subtitle: Text(fields?.location ?? 'N/A'),
                  ),
                  Divider(),
                  // Maintainer
                  ListTile(
                    leading: Icon(Icons.build, color: Colors.blue),
                    title: Text('Maintainer'),
                    subtitle: Text(fields?.maintainer ?? 'N/A'),
                  ),
                  Divider(),
                  // In Operation
                  ListTile(
                    leading: Icon(Icons.access_time, color: Colors.green),
                    title: Text('In Operation'),
                    subtitle: Text(fields?.inOperation ?? 'N/A'),
                  ),
                  Divider(),
                  // Pet Friendly
                  ListTile(
                    leading: Icon(Icons.pets, color: Colors.orange),
                    title: Text('Pet Friendly'),
                    subtitle: Text(fields?.petFriendly ?? 'N/A'),
                  ),
                  Divider(),
                  // Geo Local Area
                  ListTile(
                    leading: Icon(Icons.map, color: Colors.purple),
                    title: Text('Geo Local Area'),
                    subtitle: Text(fields?.geoLocalArea ?? 'N/A'),
                  ),
                  SizedBox(height: 20),
                  // Open in Google Maps Button
                  ElevatedButton.icon(
                    icon: Icon(Icons.map),
                    label: Text('Open in Google Maps'),
                    onPressed: () {
                      if (fields?.geoPoint2d != null) {
                        // _launchMaps(
                        //   fields!.geoPoint2d!.latitude!,
                        //   fields!.geoPoint2d!.longitude!,
                        // );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Location data not available'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchMaps(double latitude, double longitude) async {
    final Uri url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not open the map.';
    }
  }
}
