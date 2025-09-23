import 'package:isp/domain/datasources/reports_datasource.dart';
import 'package:isp/domain/entities/report.dart';
import 'package:isp/domain/repositories/reports_repository.dart';

class ReportRepositoryImpl extends ReportsRepository {
  final ReportsDatasource datasource;
  ReportRepositoryImpl({required this.datasource});

  @override
  Future<List<Report>> getReports() {
    return datasource.getReports();
  }
}
