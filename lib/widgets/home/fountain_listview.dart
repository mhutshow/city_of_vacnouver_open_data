import 'package:flutter/material.dart';
import 'package:vancouver_open_data/config/styles.dart';
import 'dart:math' as math;

class FountainListItem extends StatelessWidget {
  final dynamic fountain;
  final int index;

  const FountainListItem({Key? key, this.fountain, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name Row with Icon
                Row(
                  children: [
                    const Icon(
                      Icons.water_drop_outlined, // Icon for the name
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        // Remove any newlines from the name
                        (fountain?.name ?? 'No name available').replaceAll('\n', ' '),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1, // Ensures ellipsis is applied if text overflows
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                // Location Row with Icon
                Row(
                  children: [
                    const Icon(
                      Icons.location_on, // Icon for location
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        fountain?.location ?? 'No location available',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1, // Ensures ellipsis is applied if text overflows
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                // Area information
                if (fountain?.geoLocalArea != null)
                  Row(
                    children: [
                      const Icon(
                        Icons.map, // Icon for area
                        color: Colors.green,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          'Area: ${fountain?.geoLocalArea}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0, // Ensures that the strip is vertically centered
          left: 0,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 60, // You can adjust this height
              width: 5,
              decoration: BoxDecoration(
                color: randomColors[index% randomColors.length],
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
