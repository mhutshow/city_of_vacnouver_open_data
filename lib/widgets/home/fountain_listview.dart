import 'package:flutter/material.dart';
import '../../config/styles.dart';

class FountainListItem extends StatelessWidget {
  final dynamic fountain;
  final int index;
  final bool isSelected;

  const FountainListItem({
    Key? key,
    this.fountain,
    required this.index,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.shade100 : Colors.white,
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
            padding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    const Icon(
                      Icons.water_drop_outlined,
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(

                        (fountain?.name ?? 'No name available')
                            .replaceAll('\n', ' '),
                        overflow: TextOverflow.ellipsis,
                        maxLines:
                        1,
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
                      Icons.location_on,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        fountain?.location ?? 'No location available',
                        overflow: TextOverflow.ellipsis,
                        maxLines:
                        1,
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
                        Icons.map,
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
          bottom: 0,
          left: 0,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 60,
              width: 5,
              decoration: BoxDecoration(
                color: randomColors[index % randomColors.length],
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
