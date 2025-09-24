import 'package:flutter_riverpod/legacy.dart';
import 'package:isp/domain/entities/report.dart';
import 'package:isp/presentation/providers/reports/report_repository_providers.dart';

final getReportsProvider = StateNotifierProvider<ReportsNotifier, List<Report>>(
  (ref) {
    final fetchMoreReports = ref.watch(reportRepositoryProvider).getReports;
    return ReportsNotifier(fetchMoreReports: fetchMoreReports);
  },
);

typedef ReportCallback = Future<List<Report>> Function({int page, int size});

class ReportsNotifier extends StateNotifier<List<Report>> {
  final ReportCallback fetchMoreReports;
  int _currentPage = 0;
  final int _pageSize = 10;
  bool _hasMore = true;

  ReportsNotifier({required this.fetchMoreReports}) : super([]);

  Future<void> loadNextPage() async {
    if (!_hasMore) return;

    final List<Report> reports = await fetchMoreReports(
      page: _currentPage,
      size: _pageSize,
    );

    if (reports.length < _pageSize) {
      _hasMore = false;
    }

    _currentPage++;
    state = [...state, ...reports];
  }

  void reset() {
    _currentPage = 0;
    _hasMore = true;
    state = [];
  }
}
