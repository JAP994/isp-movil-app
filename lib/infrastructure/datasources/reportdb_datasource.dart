import 'package:dio/dio.dart';
import 'package:isp/domain/datasources/reports_datasource.dart';
import 'package:isp/domain/entities/report.dart';
import 'package:isp/infrastructure/mappers/report_mapper.dart';
import 'package:isp/infrastructure/models/reportdb/reportdb_response.dart';

class ReportdbDatasource extends ReportsDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://springboot-app-9i67.onrender.com/sistem/api/v1/reports',
      // baseUrl: 'http://localhost:8080/sistem/api/v1/reports',
    ),
  );

  @override
  Future<List<Report>> getReports({int page = 0, int size = 10}) async {
    final response = await dio.get(
      '',
      queryParameters: {'page': page, 'size': size},
    );

    final data = response.data['content'] as List<dynamic>;
    final List<Report> reports = data
        .map(
          (json) =>
              ReportMapper.reportDBToEntity(ReportDbResponse.fromJson(json)),
        )
        .toList();

    return reports;
  }
}
