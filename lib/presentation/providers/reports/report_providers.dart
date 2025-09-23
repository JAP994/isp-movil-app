import 'package:flutter_riverpod/legacy.dart';
import 'package:isp/domain/entities/report.dart';
import 'package:isp/presentation/providers/reports/report_repository_providers.dart';

final getReportsProvider = StateNotifierProvider<ReportsNotifier, List<Report>>(
  (ref) {
    final fetchMoreReports = ref.watch(reportRepositoryProvider).getReports;
    return ReportsNotifier(fetchMoreReports: fetchMoreReports);
  },
);

typedef ReportCallback = Future<List<Report>> Function();

class ReportsNotifier extends StateNotifier<List<Report>> {
  ReportCallback fetchMoreReports;

  ReportsNotifier({required this.fetchMoreReports}) : super([]);

  Future<void> loadNextPage() async {
    final List<Report> reports = await fetchMoreReports();
    state = [...state, ...reports];
  }
}
