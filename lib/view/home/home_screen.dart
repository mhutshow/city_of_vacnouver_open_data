import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../controller/api_controller.dart';
import '../../widgets/app_bar_with_search.dart';
import '../../widgets/responsive.dart';
import 'mobile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiController controller = Get.find<ApiController>();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<String> _selectedAreas = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  // Show filter options using multi_select_flutter
  void _showFilterOptions(BuildContext context) {
    final areas = controller.data
        .map((record) => record.record?.fields?.geoLocalArea ?? '')
        .toSet();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectBottomSheet(
          items: areas.map((area) => MultiSelectItem(area, area)).toList(),
          initialValue: _selectedAreas,
          onConfirm: (values) {
            setState(() {
              _selectedAreas = List<String>.from(values);
            });
          },
          maxChildSize: 0.8,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value && controller.data.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.data.isEmpty) {
          return const Center(child: Text('No data available.'));
        } else {
          return Responsive(
            mobile: MobileScreen(
              controller: controller,
              searchController: _searchController,
              searchQuery: _searchQuery,
              selectedAreas: _selectedAreas,
              onSearchChanged: _onSearchChanged,
              showFilterOptions: _showFilterOptions,
            ),
            tablet: _buildCardList(context, controller, axisCount: 2),
            desktop: _buildCardList(context, controller, axisCount: 3),
          );
        }
      }),
    );
  }

  // Build the grid list of cards for tablet and desktop
  Widget _buildCardList(BuildContext context, ApiController controller,
      {int axisCount = 1}) {
    final filteredData = controller.data.where((record) {
      final fields = record.record?.fields;
      final matchesSearch =
          fields?.name?.toLowerCase().contains(_searchQuery) ?? false;
      final matchesArea = _selectedAreas.isEmpty ||
          _selectedAreas.contains(fields?.geoLocalArea ?? '');
      return matchesSearch && matchesArea;
    }).toList();

    return Scaffold(
      appBar: appbarWithSearch(
        buttonTitle: "Filter",
        onChanged: (value) {
          setState(() {
            _searchQuery = value.toLowerCase(); // Capture search input
          });
        },
        icon: Icons.filter_alt,
        onPressed: () {
          _showFilterOptions(context); // Show filter options
        },
        title: "Drinking Water Fountains",
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels ==
              scrollInfo.metrics.maxScrollExtent &&
              !controller.isLoadMore.value) {
            controller.loadMoreData(); // Load more data when reaching the bottom
          }
          return false;
        },
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: axisCount,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.5,
          ),
          padding: const EdgeInsets.all(20),
          itemCount: filteredData.length,
          itemBuilder: (context, index) {
            var fountain = filteredData[index].record?.fields;
            return GestureDetector(
              onTap: () {
                // Add any tap interactions here
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fountain?.name ?? 'No name available',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(fountain?.location ?? 'No location available'),
                      const Spacer(),
                      if (fountain?.geoLocalArea != null)
                        Text('Area: ${fountain?.geoLocalArea}',
                            style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
