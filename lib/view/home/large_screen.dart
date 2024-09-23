import 'package:flutter/material.dart';
import '../../controller/api_controller.dart';
import '../../model/fountain_model.dart';
import 'mobile_screen.dart';
import '../details/detail_screen.dart';

class LargeScreen extends StatefulWidget {
  final ApiController apiController;
  final String searchQuery;
  final List<String> selectedAreas;
  final String sortOrder;
  final Function(String?) onSortOrderChanged;
  final TextEditingController searchController;
  final Function(BuildContext) showFilterOptions;

  const LargeScreen({
    Key? key,
    required this.apiController,
    required this.searchQuery,
    required this.selectedAreas,
    required this.sortOrder,
    required this.onSortOrderChanged,
    required this.searchController,
    required this.showFilterOptions,
  }) : super(key: key);

  @override
  _LargeScreenState createState() => _LargeScreenState();
}

class _LargeScreenState extends State<LargeScreen> {
  RecordData? _selectedRecord;

  @override
  void initState() {
    super.initState();
    if (widget.apiController.data.isNotEmpty) {
      _selectedRecord = widget.apiController.data.first.record;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = widget.apiController.data.where((record) {
      final fields = record.record?.fields;
      final matchesSearch =
          fields?.name?.toLowerCase().contains(widget.searchQuery) ?? false;
      final matchesArea = widget.selectedAreas.isEmpty ||
          widget.selectedAreas.contains(fields?.geoLocalArea ?? '');
      return matchesSearch && matchesArea;
    }).toList();

    filteredData.sort((a, b) {
      final nameA = a.record?.fields?.name?.toLowerCase() ?? '';
      final nameB = b.record?.fields?.name?.toLowerCase() ?? '';
      return widget.sortOrder == 'Ascending'
          ? nameA.compareTo(nameB)
          : nameB.compareTo(nameA);
    });

    if (_selectedRecord == null ||
        !filteredData.any((record) => record.record == _selectedRecord)) {
      _selectedRecord =
      filteredData.isNotEmpty ? filteredData.first.record : null;
    }

    final double mobileViewWidth = 450;

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            SizedBox(
              width: mobileViewWidth,
              child: MobileScreen(
                apiController: widget.apiController,
                searchController: widget.searchController,
                searchQuery: widget.searchQuery,
                selectedAreas: widget.selectedAreas,
                onSearchChanged: () => setState(() {}),
                showFilterOptions: widget.showFilterOptions,
                sortOrder: widget.sortOrder,
                onSortOrderChanged: widget.onSortOrderChanged,
                onItemSelected: (record) {
                  setState(() {
                    _selectedRecord = record;
                  });
                },
                selectedRecord: _selectedRecord,
              ),
            ),
            Expanded(
              child: _selectedRecord != null
                  ? Container(
                margin: const EdgeInsets.all(16),
                height: double.maxFinite,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Center(
                  child: DetailScreen(
                    record: _selectedRecord!,
                    isFullScreen: false,
                  ),
                ),
              )
                  : const Center(child: Text('Select an item to view details')),
            ),
          ],
        ),
      ),
    );
  }
}
