import 'dart:io';
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
  Future<List<Report>> getReports({int page = 0, int size = 10}) async {
    final response = await dio.get(
      '',
      queryParameters: {'page': page, 'size': size},
    );
    final data = response.data['content'] as List<dynamic>;
    return data
        .map(
          (json) =>
              ReportMapper.reportDBToEntity(ReportDbResponse.fromJson(json)),
        )
        .toList();
  }

  @override
  Future<Report> createReport({
    required File file,
    required String detectedDateTime,
    required String detectedLocationUnit,
    required String involvedMaterialPersonnel,
    required String detailedDescription,
  }) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
      'detectedDateTime': detectedDateTime,
      'detectedLocationUnit': detectedLocationUnit,
      'involvedMaterialPersonnel': involvedMaterialPersonnel,
      'detailedDescription': detailedDescription,
    });

    final response = await dio.post('/upload', data: formData);
    return ReportMapper.reportDBToEntity(
      ReportDbResponse.fromJson(response.data),
    );
  }
}
