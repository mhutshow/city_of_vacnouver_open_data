import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../controller/api_controller.dart';
import '../../model/fountain_model.dart';
import '../../widgets/common/Responsive.dart';
import 'mobile_screen.dart';
import '../details/detail_screen.dart';
import 'large_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiController apiController = Get.find<ApiController>();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<String> _selectedAreas = [];
  String _sortOrder = 'Ascending';
  RecordData? _selectedRecord;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    if (apiController.data.isNotEmpty) {
      _selectedRecord = apiController.data.first.record;
    }
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

  void _onSortOrderChanged(String? newSortOrder) {
    setState(() {
      _sortOrder = newSortOrder!;
    });
  }

  void _showFilterOptions(BuildContext context) {
    final areas = apiController.data
        .map((record) => record.record?.fields?.geoLocalArea ?? '')
        .toSet();
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      useSafeArea: true,
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (apiController.isLoading.value && apiController.data.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (apiController.data.isEmpty) {
          return const Center(child: Text('No data available.'));
        } else {
          return Responsive(
            mobile: MobileScreen(
              apiController: apiController,
              searchController: _searchController,
              searchQuery: _searchQuery,
              selectedAreas: _selectedAreas,
              onSearchChanged: _onSearchChanged,
              showFilterOptions: _showFilterOptions,
              sortOrder: _sortOrder,
              onSortOrderChanged: _onSortOrderChanged,
            ),
            tablet: MobileScreen(
              apiController: apiController,
              searchController: _searchController,
              searchQuery: _searchQuery,
              selectedAreas: _selectedAreas,
              onSearchChanged: _onSearchChanged,
              showFilterOptions: _showFilterOptions,
              sortOrder: _sortOrder,
              onSortOrderChanged: _onSortOrderChanged,
            ),
            desktop: LargeScreen(
              apiController: apiController,
              searchQuery: _searchQuery,
              selectedAreas: _selectedAreas,
              sortOrder: _sortOrder,
              onSortOrderChanged: _onSortOrderChanged,
              searchController: _searchController,
              showFilterOptions: _showFilterOptions,
            ),
          );
        }
      }),
    );
  }
}
