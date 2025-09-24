import 'dart:io';

import 'package:isp/domain/entities/report.dart';

abstract class ReportsDatasource {
  // Agregamos parámetros opcionales para paginación
  Future<List<Report>> getReports({int page = 0, int size = 10});

  /// Nueva función para crear reporte
  Future<Report> createReport({
    required File file,
    required String detectedDateTime,
    required String detectedLocationUnit,
    required String involvedMaterialPersonnel,
    required String detailedDescription,
  });
}
