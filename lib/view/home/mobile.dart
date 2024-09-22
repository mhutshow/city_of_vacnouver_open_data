import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/styles.dart';
import '../../controller/api_controller.dart';
import '../../widgets/app_bar_with_search.dart';

class MobileScreen extends StatefulWidget {
  final ApiController controller;
  final TextEditingController searchController;
  final String searchQuery;
  final List<String> selectedAreas;
  final VoidCallback onSearchChanged;
  final Function(BuildContext) showFilterOptions;

  const MobileScreen({
    Key? key,
    required this.controller,
    required this.searchController,
    required this.searchQuery,
    required this.selectedAreas,
    required this.onSearchChanged,
    required this.showFilterOptions,
  }) : super(key: key);

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final filteredData = controller.data.where((record) {
      final fields = record.record?.fields;
      final matchesSearch =
          fields?.name?.toLowerCase().contains(widget.searchQuery) ?? false;
      final matchesArea = widget.selectedAreas.isEmpty ||
          widget.selectedAreas.contains(fields?.geoLocalArea ?? '');
      return matchesSearch && matchesArea;
    }).toList();

    return Scaffold(
      appBar: appbarWithSearch(
        buttonTitle: "Filter",
        onChanged: (value) {
          setState(() {
            widget.searchController.text = value;
            widget.onSearchChanged();
          });
        },
        icon: Icons.filter_alt,
        onPressed: () {
          widget.showFilterOptions(context);
        },
        title: "Drinking Water Fountains",
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.data.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.data.isEmpty) {
          return const Center(child: Text('No data available.'));
        } else {
          return SafeArea(
            child: Column(
              children: [
                const StatisticsDisplay(),
                const SizedBox(height: 50),
                const SortSection(),
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                          !controller.isLoadMore.value) {
                        controller.loadMoreData();
                      }
                      return false;
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        var fountain = filteredData[index].record?.fields;
                        return FountainListItem(fountain: fountain);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

class StatisticsDisplay extends StatelessWidget {
  const StatisticsDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 70,
          width: double.infinity,
          color: primaryColor,
        ),
        Positioned(
          top: 30,
          left: 20,
          right: 20,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                )
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatisticsColumn(title: "Total", value: "150"),
                  StatisticsColumn(title: "Friendly", value: "75"),
                  StatisticsColumn(title: "In operation", value: "75"),
                  StatisticsColumn(title: "Maintainer", value: "5"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class StatisticsColumn extends StatelessWidget {
  final String title;
  final String value;

  const StatisticsColumn({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(title),
      ],
    );
  }
}

class SortSection extends StatelessWidget {
  const SortSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "All data",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: const [
              Text(
                "Sort by",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.sort,
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FountainListItem extends StatelessWidget {
  final dynamic fountain;

  const FountainListItem({Key? key, this.fountain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fountain?.name ?? 'No name available',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(fountain?.location ?? 'No location available'),
            const SizedBox(height: 5),
            if (fountain?.geoLocalArea != null)
              Text('Area: ${fountain?.geoLocalArea}'),
          ],
        ),
      ),
    );
  }
}
