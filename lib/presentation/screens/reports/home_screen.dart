import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp/presentation/providers/providers.dart';
import 'package:isp/presentation/screens/screens.dart'; // Exporta PostScreen
import 'package:go_router/go_router.dart';

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
    // Cargar la primera página de reportes
    ref.read(getReportsProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final getReports = ref.watch(getReportsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Informes Situación de Peligro")),
      body: getReports.isEmpty
          ? const Center(
              child:
                  CircularProgressIndicator(), // Mostramos spinner mientras carga
            )
          : ListView.builder(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(PostScreen.name).then((_) {
            // Refrescar reportes al regresar
            ref.read(getReportsProvider.notifier).reset();
            ref.read(getReportsProvider.notifier).loadNextPage();
          });
        },
        tooltip: 'Nuevo reporte',
        child: const Icon(Icons.add),
      ),
    );
  }
}
