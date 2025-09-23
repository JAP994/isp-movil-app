import 'package:dio/dio.dart';
import 'package:isp/domain/datasources/reports_datasource.dart';
import 'package:isp/domain/entities/report.dart';
import 'package:isp/infrastructure/mappers/report_mapper.dart';
import 'package:isp/infrastructure/models/reportdb/reportdb_response.dart';

class ReportdbDatasource extends ReportsDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://springboot-app-9i67.onrender.com/sistem/api/v1/reports',
    ),
  );

  @override
  Future<List<Report>> getReports() async {
    final response = await dio.get('');
    final List<dynamic> data = response.data;
    final List<Report> reports = data
        .map(
          (json) =>
              ReportMapper.reportDBToEntity(ReportDbResponse.fromJson(json)),
        )
        .toList();

    return reports;
  }
}
