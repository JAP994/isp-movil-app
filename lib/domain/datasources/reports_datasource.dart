import 'package:isp/domain/entities/report.dart';

abstract class ReportsDatasource {
  // Agregamos parámetros opcionales para paginación
  Future<List<Report>> getReports({int page = 0, int size = 10});
}
