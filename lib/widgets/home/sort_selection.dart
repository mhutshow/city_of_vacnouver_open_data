import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vancouver_open_data/controller/api_controller.dart';

class SortSection extends StatelessWidget {
  final String sortOrder;
  final ValueChanged<String?> onSortOrderChanged;

  const SortSection({
    Key? key,
    required this.sortOrder,
    required this.onSortOrderChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => Text(
              "Fetched: ${Get.find<ApiController>().data.length}/${Get.find<ApiController>().maxDataCount.value}",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: [
              const Text(
                "Sort by",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 10),
              DropdownButton<String>(
                underline: SizedBox.shrink(),
                value: sortOrder,
                onChanged: (newValue) {
                  if (newValue != null) {
                    onSortOrderChanged(newValue);
                  }
                },
                focusColor: Colors.transparent,
                items: const [
                  DropdownMenuItem(
                    value: 'Ascending',
                    child: Text('Ascending'),
                  ),
                  DropdownMenuItem(
                    value: 'Descending',
                    child: Text('Descending'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
