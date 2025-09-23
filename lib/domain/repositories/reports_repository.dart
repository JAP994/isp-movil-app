import 'package:isp/domain/entities/report.dart';

abstract class ReportsRepository {
  Future<List<Report>> getReports();
}
