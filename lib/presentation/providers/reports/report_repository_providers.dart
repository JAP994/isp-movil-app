import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp/infrastructure/datasources/reportdb_datasource.dart';
import 'package:isp/infrastructure/repositories/report_repository_impl.dart';

// Este repositorio es inmutable
final reportRepositoryProvider = Provider<ReportRepositoryImpl>((ref) {
  final datasource = ReportdbDatasource();
  return ReportRepositoryImpl(datasource: datasource);
});
