import 'dart:io';

import 'package:isp/domain/datasources/reports_datasource.dart';
import 'package:isp/domain/entities/report.dart';
import 'package:isp/domain/repositories/reports_repository.dart';

class ReportRepositoryImpl extends ReportsRepository {
  final ReportsDatasource datasource;
  ReportRepositoryImpl({required this.datasource});

  @override
  Future<List<Report>> getReports({int page = 0, int size = 10}) {
    return datasource.getReports(page: page, size: size);
  }

  @override
  Future<Report> createReport({
    required File file,
    required String detectedDateTime,
    required String detectedLocationUnit,
    required String involvedMaterialPersonnel,
    required String detailedDescription,
  }) {
    return datasource.createReport(
      file: file,
      detectedDateTime: detectedDateTime,
      detectedLocationUnit: detectedLocationUnit,
      involvedMaterialPersonnel: involvedMaterialPersonnel,
      detailedDescription: detailedDescription,
    );
  }
}
