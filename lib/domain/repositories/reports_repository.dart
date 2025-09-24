import 'package:isp/domain/entities/report.dart';

abstract class ReportsRepository {
  /// Obtiene una lista de reportes con paginación
  /// [page] número de página (empezando desde 0)
  /// [size] cantidad de elementos por página
  Future<List<Report>> getReports({int page = 0, int size = 10});
}
