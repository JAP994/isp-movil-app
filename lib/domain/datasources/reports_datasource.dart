import 'package:isp/domain/entities/report.dart';

abstract class ReportsDatasource {
  Future<List<Report>> getReport({int page = 1});
}
