import 'package:get/get.dart';
import 'package:vancouver_open_data/helpers/snackbar.dart';
import '../model/fountain_model.dart';
import '../services/api_service.dart';

class ApiController extends GetxController {
  var isLoading = true.obs;
  var isLoadMore = false.obs;
  var data = <Record>[].obs;
  var page = 1;
  final int limitPerPage = 20;
  ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchFountainData();
  }

  // Fetch fountain data from the API
  void fetchFountainData() async {
    try {
      isLoading(true);
      FountainModel response = await apiService.getFountainData(page: page, limitPerPage: limitPerPage);
      if (response.records != null && response.records!.isNotEmpty) {
        data.addAll(response.records!);
      }

    } catch (e) {
      SnackbarHelper.showError(
        title: 'Error',
        description: e.toString(),
      );
    } finally {
      isLoading(false);
    }
  }


  //Load more data by changing the page number
  void loadMoreData() async {
    //Prevent loading more data if already loading or if there's no more data to load
    if (isLoading.value || isLoadMore.value) return;

    try {
      isLoadMore(true);
      page++;
      FountainModel response = await apiService.getFountainData(page: page, limitPerPage: limitPerPage);
      if (response.records != null && response.records!.isNotEmpty) {
        data.addAll(response.records!);
      } else {
        // Revert the page if no more data is available
        page--;
      }
    } catch (e) {
      SnackbarHelper.showError(
        title: 'Error',
        description: e.toString(),
      );
      // Revert the page if an error occurs
      page--;
    } finally {
      isLoadMore(false);
    }
  }
}
