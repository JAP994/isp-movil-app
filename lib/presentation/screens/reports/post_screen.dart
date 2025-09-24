import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp/presentation/providers/providers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class PostScreen extends ConsumerStatefulWidget {
  static const name = 'post-screen';
  const PostScreen({super.key});

  @override
  ConsumerState<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedFile;

  final _detectedDateTimeController = TextEditingController();
  final _detectedLocationUnitController = TextEditingController();
  final _involvedMaterialPersonnelController = TextEditingController();
  final _detailedDescriptionController = TextEditingController();

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg'],
      withData: false,
    );

    if (result != null && result.files.single.path != null) {
      final pickedFile = File(result.files.single.path!);

      // Validación de extensión
      final extension = pickedFile.path.split('.').last.toLowerCase();
      if (!['pdf', 'jpg', 'jpeg'].contains(extension)) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Solo se permiten archivos PDF o JPG.',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        _selectedFile = pickedFile;
      });
    }
  }

  Future<void> _pickDateTime() async {
    DateTime now = DateTime.now();

    if (!mounted) return;
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: now,
    );

    if (!mounted || pickedDate == null) return;

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now),
    );

    if (!mounted || pickedTime == null) return;

    DateTime combined = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    if (combined.isAfter(now)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No se permite seleccionar fecha/hora futura',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _detectedDateTimeController.text = DateFormat(
      'dd/MM/yyyy HH:mm',
    ).format(combined);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedFile == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Debe seleccionar un archivo.',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await ref
        .read(createReportProvider.notifier)
        .createReport(
          file: _selectedFile!,
          detectedDateTime: _detectedDateTimeController.text,
          detectedLocationUnit: _detectedLocationUnitController.text,
          involvedMaterialPersonnel: _involvedMaterialPersonnelController.text,
          detailedDescription: _detailedDescriptionController.text,
        );

    final state = ref.read(createReportProvider);

    if (state.error != null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: ${state.error}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else if (state.report != null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Reporte creado correctamente',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.green,
        ),
      );

      // Limpiar campos y archivo seleccionado
      _formKey.currentState!.reset();
      setState(() => _selectedFile = null);
      _detectedDateTimeController.clear();
      _detectedLocationUnitController.clear();
      _involvedMaterialPersonnelController.clear();
      _detailedDescriptionController.clear();
      ref.read(createReportProvider.notifier).reset();

      // Actualizar HomeScreen al regresar
      ref.read(getReportsProvider.notifier).reset();
      ref.read(getReportsProvider.notifier).loadNextPage();
    }
  }

  @override
  void dispose() {
    _detectedDateTimeController.dispose();
    _detectedLocationUnitController.dispose();
    _involvedMaterialPersonnelController.dispose();
    _detailedDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(createReportProvider).isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Reporte')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Campo de fecha/hora solo con picker, no editable manualmente
                GestureDetector(
                  onTap: _pickDateTime,
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: _detectedDateTimeController,
                      decoration: InputDecoration(
                        labelText: 'Fecha y hora detectada (dd/MM/yyyy HH:mm)',
                        suffixIcon: const Icon(Icons.calendar_today),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obligatorio';
                        }
                        try {
                          DateTime dt = DateFormat(
                            'dd/MM/yyyy HH:mm',
                          ).parseStrict(value);
                          if (dt.isAfter(DateTime.now())) {
                            return 'No se permite fecha/hora futura';
                          }
                        } catch (_) {
                          return 'Formato inválido';
                        }
                        return null;
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                TextFormField(
                  controller: _detectedLocationUnitController,
                  decoration: const InputDecoration(
                    labelText: 'Unidad detectada',
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Campo obligatorio'
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _involvedMaterialPersonnelController,
                  decoration: const InputDecoration(
                    labelText: 'Materiales o personal involucrado',
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Campo obligatorio'
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _detailedDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descripción detallada',
                  ),
                  maxLines: 4,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Campo obligatorio'
                      : null,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickFile,
                      child: const Text('Seleccionar archivo'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _selectedFile != null
                            ? _selectedFile!.path.split('/').last
                            : 'Ningún archivo seleccionado',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                if (_selectedFile != null)
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _selectedFile!.path.toLowerCase().endsWith('.pdf')
                        ? Row(
                            children: const [
                              Icon(
                                Icons.picture_as_pdf,
                                color: Colors.red,
                                size: 40,
                              ),
                              SizedBox(width: 10),
                              Text("Archivo PDF seleccionado"),
                            ],
                          )
                        : Image.file(
                            _selectedFile!,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                  ),

                const SizedBox(height: 20),
                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _submit,
                        child: const Text('Enviar reporte'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
