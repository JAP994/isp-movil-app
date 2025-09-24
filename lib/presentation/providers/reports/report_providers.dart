import 'dart:io';
import 'package:flutter_riverpod/legacy.dart';
import 'package:isp/domain/entities/report.dart';
import 'package:isp/presentation/providers/reports/report_repository_providers.dart';

/// --- GET Reports ---
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

    if (reports.length < _pageSize) _hasMore = false;

    _currentPage++;
    state = [...state, ...reports];
  }

  void reset() {
    _currentPage = 0;
    _hasMore = true;
    state = [];
  }
}

/// --- CREATE Report ---
final createReportProvider =
    StateNotifierProvider<CreateReportNotifier, CreateReportState>(
      (ref) => CreateReportNotifier(ref.watch(reportRepositoryProvider)),
    );

class CreateReportState {
  final bool isLoading;
  final Report? report;
  final String? error;

  CreateReportState({this.isLoading = false, this.report, this.error});

  CreateReportState copyWith({bool? isLoading, Report? report, String? error}) {
    return CreateReportState(
      isLoading: isLoading ?? this.isLoading,
      report: report ?? this.report,
      error: error ?? this.error,
    );
  }
}

class CreateReportNotifier extends StateNotifier<CreateReportState> {
  final dynamic repository; // tu ReportRepositoryImpl

  CreateReportNotifier(this.repository) : super(CreateReportState());

  Future<void> createReport({
    required File file,
    required String detectedDateTime,
    required String detectedLocationUnit,
    required String involvedMaterialPersonnel,
    required String detailedDescription,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final Report created = await repository.createReport(
        file: file,
        detectedDateTime: detectedDateTime,
        detectedLocationUnit: detectedLocationUnit,
        involvedMaterialPersonnel: involvedMaterialPersonnel,
        detailedDescription: detailedDescription,
      );

      state = state.copyWith(isLoading: false, report: created);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() {
    state = CreateReportState();
  }
}
