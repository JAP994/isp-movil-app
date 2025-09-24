import 'dart:io';

import 'package:isp/domain/entities/report.dart';

abstract class ReportsRepository {
  Future<List<Report>> getReports({int page = 0, int size = 10});

  /// Crear reporte
  Future<Report> createReport({
    required File file,
    required String detectedDateTime,
    required String detectedLocationUnit,
    required String involvedMaterialPersonnel,
    required String detailedDescription,
  });
}
