import '../config/api.dart';
import '../helpers/snackbar.dart';
import '../model/fountain_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  Future<FountainModel> getFountainData({int page = 1, int limitPerPage = 100}) async {
    try {
      final int offset = (page - 1) * limitPerPage;
      final response = await Api().dio.get(
        'api/v2/catalog/datasets/drinking-fountains/records',
        queryParameters: {
          'limit': limitPerPage,
          'offset': offset,
        },
      );

      if (response.statusCode == 200) {
        FountainModel fountainModel = FountainModel.fromJson(response.data);
        return fountainModel;
      } else {
        SnackbarHelper.showError(
          title: 'Error ${response.statusCode}',
          description: response.statusMessage ?? 'Failed to load data',
        );
        throw Exception('Failed to load data, status code: ${response.statusCode}');
      }
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        SnackbarHelper.showError(
          title: 'Error ${dioError.response?.statusCode}',
          description: dioError.response?.statusMessage ?? 'An error occurred',
        );
      } else {
        SnackbarHelper.showError(
          title: 'Error',
          description: dioError.message ?? 'An error occurred',
        );
      }
      rethrow;
    } catch (e) {
      SnackbarHelper.showError(
        title: 'Error',
        description: e.toString(),
      );
      rethrow;
    }
  }
}
