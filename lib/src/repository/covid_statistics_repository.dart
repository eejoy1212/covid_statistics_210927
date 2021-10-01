import 'package:covid_statistics_210927/model/covid_statistics.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

class CovidStatisticsRepository {
  late var _dio;

  CovidStatisticsRepository() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://openapi.data.go.kr',
        queryParameters: {
          'ServiceKey':
              'ScZofmKV%2BPj2FaZjooaV71UJYmBnoOl%2FC5Qv%2FbcfqmNmqqtHmQVguUncZXUYLEgI%2FW0fbeWlP4Fg1%2BLtBhcjGQ%3D%3D',
        },
      ),
    );
  }

  Future<List<Covid19StatisticsModel>> fetchCovid19Statistics(
      {String? startDate, String? endDate}) async {
    var query = Map<String, String>();
    if (startDate != null) query.putIfAbsent('startCreateDt', () => startDate);
    if (endDate != null) query.putIfAbsent('endCreateDt', () => endDate);
    var response = await _dio.get(
        // '/openapi/service/rest/Covid19/getCovid19InfStateJson?ServiceKey=ScZofmKV%2BPj2FaZjooaV71UJYmBnoOl%2FC5Qv%2FbcfqmNmqqtHmQVguUncZXUYLEgI%2FW0fbeWlP4Fg1%2BLtBhcjGQ%3D%3D&startCreateDt=20210926&endCreateDt=20210927',
        '/openapi/service/rest/Covid19/getCovid19InfStateJson?ServiceKey=ScZofmKV%2BPj2FaZjooaV71UJYmBnoOl%2FC5Qv%2FbcfqmNmqqtHmQVguUncZXUYLEgI%2FW0fbeWlP4Fg1%2BLtBhcjGQ%3D%3D&startCreateDt=20210921&endCreateDt=20210929',
        queryParameters: query);
    final document = XmlDocument.parse(response.data);
    final results = document.findAllElements('item');
    if (results.isNotEmpty) {
      return results
          .map<Covid19StatisticsModel>(
              (element) => Covid19StatisticsModel.fromXml(element))
          .toList();
    } else {
      return Future.value(null);
    }
  }
}
