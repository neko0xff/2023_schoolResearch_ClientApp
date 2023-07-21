// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:viewapp_v1_1/modules/PreferencesUtil.dart';

void main() {
  runApp(const CreatePDFViewPage());
}

class CreatePDFViewPage extends StatelessWidget {
  const CreatePDFViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PDFScreen(),
    );
  }
}

class PDFScreen extends StatefulWidget {
  const PDFScreen({Key? key}) : super(key: key);

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  late Future<Map<String, dynamic>> _dataFuture;
  String pdfFile = '';
  pw.Document pdf = pw.Document();
  GlobalKey tableKey = GlobalKey();
  String id = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void initState() {
    super.initState();
    _dataFuture = getData();
  }

  Future<Map<String, dynamic>> getData() async {
    const String setboards = "Sensor01";
    final String? serverSource =
        await PreferencesUtil.getString("serverSource");
    final Uri uri = Uri.http(serverSource!, "/read/$setboards/ALL");
    final response = await http.get(uri);
    final result = response.body;
    final data = jsonDecode(result);
    print(data[0]);
    return Map<String, dynamic>.from(data[0]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _dataFuture,
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final data = snapshot.data!;
          return view(data);
        }
      },
    );
  }

  Widget view(Map<String, dynamic> data) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              const BtnViewTable(),
              const SizedBox(width: 10.0),
              ElevatedButton(
                onPressed: () {
                  createPdfFile(data);
                  savePdfFile();
                },
                child: const Text('Output PDF'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          "Save a File=$pdfFile",
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5.0),
        Visibility(
          visible: pdfFile.isNotEmpty,
          child: SizedBox(
            width: 400,
            height: 470,
            child: SfPdfViewer.file(
              File(pdfFile),
              canShowScrollHead: true,
              canShowScrollStatus: true,
            ),
          ),
        ),
      ],
    );
  }

  /* 创建 PDF 文件 */
  Future<void> createPdfFile(Map<String, dynamic> data) async {
    pdf.addPage(pw.MultiPage(
      margin: const pw.EdgeInsets.all(10),
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return <pw.Widget>[
          title1(),
          title2(),
          pw.SizedBox(width: 10.0, height: 10.0),
          buildDataTable(data),
          pw.SizedBox(width: 10.0, height: 10.0),
          UpdateDay(data),
        ];
      },
    ));
  }

  pw.Widget title1() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        pw.Text(
          'Output Data',
          textAlign: pw.TextAlign.center,
          style: const pw.TextStyle(fontSize: 28),
        ),
        pw.Divider(),
        pw.Divider(),
      ],
    );
  }

  pw.Widget title2() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        pw.Text(
          'Sensor01',
          textAlign: pw.TextAlign.center,
          style: const pw.TextStyle(fontSize: 25),
        ),
      ],
    );
  }

  pw.Widget UpdateDay(Map<String, dynamic> data) {
    return pw.Center(
      child: pw.Column(
        children: <pw.Widget>[
          pw.Text("Update Time", style: const pw.TextStyle(fontSize: 20)),
          pw.Text("Date= ${data["date"]}",
              style: const pw.TextStyle(fontSize: 20)),
          pw.Text("Time= ${data["time"]}",
              style: const pw.TextStyle(fontSize: 20)),
        ],
      ),
    );
  }

  pw.Widget buildDataTable(Map<String, dynamic> data) {
    return pw.Table(
      columnWidths: const <int, pw.TableColumnWidth>{
        0: pw.FixedColumnWidth(50), // Adjust the width of the first column
        1: pw.FixedColumnWidth(50), // Adjust the width of the second column
      },
      border: pw.TableBorder.all(width: 1), // Add border to the table
      children: [
        _buildTableRow('感測氣體', '回傳值', header: true), // Add a header row
        _buildTableRow('Temp', '${data["temp"]}'),
        _buildTableRow('Hum', '${data["hum"]}'),
        _buildTableRow('TVOC', '${data["tvoc"]}'),
        _buildTableRow('CO', '${data["co"]}'),
        _buildTableRow('CO2', '${data["co2"]}'),
        _buildTableRow('PM2.5', '${data["pm25"]}'),
        _buildTableRow('O3', '${data["o3"]}'),
      ],
    );
  }

  pw.TableRow _buildTableRow(String label, String value,
      {bool header = false}) {
    return pw.TableRow(
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
              fontSize: 25,
              fontWeight: header ? pw.FontWeight.bold : pw.FontWeight.normal),
        ),
        pw.Text(
          value,
          style: const pw.TextStyle(fontSize: 25),
        ),
      ],
    );
  }

  /* 保存 PDF 文件 */
  void savePdfFile() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File('$documentPath/$id.pdf');
    await file.writeAsBytes(await pdf.save());

    setState(() {
      pdfFile = file.path;
      pdf = pw.Document();
    });
  }
}

class BtnViewTable extends StatelessWidget {
  const BtnViewTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('Go Back'),
    );
  }
}
