import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vancouver_open_data/view/details/detail_screen.dart';
import '../../config/styles.dart';
import '../../controller/api_controller.dart';
import '../../model/fountain_model.dart';
import '../../widgets/common/app_bar_with_search.dart';
import '../../widgets/home/fountain_listview.dart';
import '../../widgets/home/sort_selection.dart';
import '../../widgets/home/statistical_display.dart';

class MobileScreen extends StatefulWidget {
  final ApiController apiController;
  final TextEditingController searchController;
  final String searchQuery;
  final List<String> selectedAreas;
  final VoidCallback onSearchChanged;
  final Function(BuildContext) showFilterOptions;
  final String sortOrder;
  final Function(String?) onSortOrderChanged;
  final Function(RecordData)? onItemSelected;
  final RecordData? selectedRecord;

  const MobileScreen({
    Key? key,
    required this.apiController,
    required this.searchController,
    required this.searchQuery,
    required this.selectedAreas,
    required this.onSearchChanged,
    required this.showFilterOptions,
    required this.sortOrder,
    required this.onSortOrderChanged,
    this.onItemSelected,
    this.selectedRecord,
  }) : super(key: key);

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = widget.apiController;
    final filteredData = controller.data.where((record) {
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

    final bool isLargeScreen = MediaQuery.of(context).size.width >= 800;

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
                const SizedBox(height: 40),
                SortSection(
                  sortOrder: widget.sortOrder,
                  onSortOrderChanged: widget.onSortOrderChanged!,
                ),
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
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        // Showing loading indicator at the bottom
                        if (controller.data.length !=
                                controller.maxDataCount.value &&
                            index + 1 == filteredData.length &&
                            widget.searchQuery.isEmpty &&
                            widget.selectedAreas.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        var fountain = filteredData[index].record?.fields;
                        return GestureDetector(
                          onTap: () {
                            if (isLargeScreen &&
                                widget.onItemSelected != null) {
                              widget
                                  .onItemSelected!(filteredData[index].record!);
                            } else {
                              Get.to(
                                () => DetailScreen(
                                  record: filteredData[index].record!,
                                  isFullScreen: true,
                                ),
                              );
                            }
                          },
                          child: FountainListItem(
                            fountain: fountain,
                            index: index,
                            isSelected: widget.selectedRecord ==
                                filteredData[index].record,
                          ),
                        );
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
