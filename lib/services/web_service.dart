import 'package:dio/dio.dart';
import 'package:find_my_therapist/model/category.dart';
import 'package:find_my_therapist/model/problem.dart';
import 'package:find_my_therapist/model/recomended_therapy.dart';

class WebService {
  static final WebService _singleton = WebService._internal();

  factory WebService() {
    return _singleton;
  }

  WebService._internal();

  final Dio _dio = Dio()..options.baseUrl = 'http://3.11.21.251/api/v1/';

  Future<Category> getCategories() async {
    try {
      final response = await _dio.get('get-client-categories');
      // print(response.data);

      return Category.fromJson(response.data);
      categoryFromJson(response.data);
    } on DioError catch (e) {
      print('getCategories $e');

      return Future.error(e);
    }
  }

  Future<Problem> getProblems() async {
    try {
      final response = await _dio.get('get-problems-list');

      return Problem.fromJson(response.data);
    } on DioError catch (e) {
      print('getProblems $e');
      print(e.request.data);

      return Future.error(e);
    }
  }

  Future<RecomendedTherapy> findRecomenedTherapy(
      int problemId, int clientId) async {
    try {
      final response = await _dio.get('find-therapy', queryParameters: {
        'problem_id': problemId,
        'client_category_id': clientId,
      });

      return RecomendedTherapy.fromJson(response.data);
    } on Exception catch (e) {
      print(e);

      return Future.error(e);
    }
  }
}
