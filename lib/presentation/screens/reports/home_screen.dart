import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp/presentation/providers/providers.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HomeView();
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(getReportsProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final getReports = ref.watch(getReportsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Reportes")),
      body: ListView.builder(
        itemCount: getReports.length,
        itemBuilder: (context, index) {
          final report = getReports[index];
          return Card(
            child: ListTile(
              title: Text(report.reportNumber),
              subtitle: Text(report.detectedLocationUnit),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }
}
