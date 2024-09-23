import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vancouver_open_data/model/fountain_model.dart';
import 'package:vancouver_open_data/widgets/common/Responsive.dart';

class DetailScreen extends StatelessWidget {
  final RecordData record;
  final bool isFullScreen;

  const DetailScreen({
    Key? key,
    required this.record,
    this.isFullScreen = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fields = record.fields;
    final content = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(fields!.name!.replaceAll('\n', ' '),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Divider(),
            if (record.id != null)
              ListTile(
                leading: Icon(Icons.fingerprint, color: Colors.blueGrey),
                title: Text('ID'),
                subtitle: Text(record.id!),
              ),
            if (record.timestamp != null)
              ListTile(
                leading: Icon(Icons.access_time, color: Colors.blueGrey),
                title: Text('Timestamp'),
                subtitle: Text(record.timestamp!),
              ),
            if (record.size != null)
              ListTile(
                leading: Icon(Icons.inbox, color: Colors.blueGrey),
                title: Text('Size'),
                subtitle: Text(record.size.toString()),
              ),
            if (fields != null) ...[
              if (fields.mapid != null)
                ListTile(
                  leading: Icon(Icons.map, color: Colors.green),
                  title: Text('Map ID'),
                  subtitle: Text(fields.mapid!),
                ),
              if (fields.name != null)
                ListTile(
                  leading: Icon(Icons.label, color: Colors.deepPurple),
                  title: Text('Name'),
                  subtitle: Text(fields.name!),
                ),
              if (fields.location != null)
                ListTile(
                  leading: Icon(Icons.location_on, color: Colors.red),
                  title: Text('Location'),
                  subtitle: Text(fields.location!),
                ),
              if (fields.maintainer != null)
                ListTile(
                  leading: Icon(Icons.build, color: Colors.blue),
                  title: Text('Maintainer'),
                  subtitle: Text(fields.maintainer!),
                ),
              if (fields.inOperation != null)
                ListTile(
                  leading: Icon(Icons.access_time, color: Colors.green),
                  title: Text('In Operation'),
                  subtitle: Text(fields.inOperation!),
                ),
              if (fields.petFriendly != null)
                ListTile(
                  leading: Icon(Icons.pets, color: Colors.orange),
                  title: Text('Pet Friendly'),
                  subtitle: Text(fields.petFriendly!),
                ),
              if (fields.photoName != null)
                ListTile(
                  leading: Icon(Icons.photo, color: Colors.blueGrey),
                  title: Text('Photo Name'),
                  subtitle: Text(fields.photoName!),
                ),
              if (fields.geoLocalArea != null)
                ListTile(
                  leading: Icon(Icons.place, color: Colors.purple),
                  title: Text('Geo Local Area'),
                  subtitle: Text(fields.geoLocalArea!),
                ),
              if (fields.geoPoint2d != null)
                ListTile(
                  leading: Icon(Icons.gps_fixed, color: Colors.teal),
                  title: Text('Geo Point 2D'),
                  subtitle: Text(
                      'Latitude: ${fields.geoPoint2d!.lat}, Longitude: ${fields.geoPoint2d!.lon}'),
                ),
              if (fields.geom != null)
                ListTile(
                  leading: Icon(Icons.linear_scale, color: Colors.indigo),
                  title: Text('Geometry'),
                  subtitle: Text('Type: ${fields.geom!.type}'),
                ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(EdgeInsets.all(16)),
                ),
                icon: Icon(Icons.map),
                label: Text('Open in Google Maps'),
                onPressed: () {
                  if (fields?.geoPoint2d != null) {
                    _launchMaps(
                      fields!.geoPoint2d!.lat!,
                      fields!.geoPoint2d!.lon!,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Location data not available'),
                      ),
                    );
                  }
                },
              )
            ],
          ],
        ),
      ),
    );

    if (Responsive.isMobile(context)) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Details'),
        ),
        body: content,
      );
    } else {
      return Material(color: Colors.white, child: content);
    }
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
