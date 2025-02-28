// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, unused_local_variable, await_only_futures, deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:viewapp_master/modules/PreferencesUtil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getNotoSerifHKMediumFont();
  runApp(const CreatePDFViewPage());
}

/* 加戴字型 */
Future<pw.Font> getNotoSerifHKMediumFont() async {
  final font = await PdfGoogleFonts.notoSerifHKMedium();
  return font;
}

class CreatePDFViewPage extends StatelessWidget {
  const CreatePDFViewPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PDFScreen(),
    );
  }
}

class PDFScreen extends StatefulWidget {
  const PDFScreen({super.key});

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  String pdfFile = '';
  pw.Document pdf = pw.Document();
  late Future<Map<String, dynamic>> _dataFuture;
  GlobalKey tableKey = GlobalKey();
  String id = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void initState() {
    super.initState();
    _dataFuture = getData();
  }

  /*獲取伺服器資料*/
  Future<Map<String, dynamic>> getData() async {
    const String setboards = "Sensor01";
    final String? serverSource =
        await PreferencesUtil.getString("serverSource");
    final Uri uri = Uri.http(serverSource!, "/read/$setboards/ALL");
    final response = await http.get(uri);
    final result = response.body;
    final data = jsonDecode(result);
    //print(data[0]);
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
              const BtnGoBack(),
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
            height: 400,
            child: SfPdfViewer.file(
              File(pdfFile),
              canShowScrollHead: true,
              canShowScrollStatus: true,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        ElevatedButton(
          onPressed: () {
            Share.shareFiles([pdfFile]);
          },
          child: const Text('Share PDF'),
        ),
      ],
    );
  }

  /* 建立 PDF 文件 */
  Future<void> createPdfFile(Map<String, dynamic> data) async {
    final pw.Font notoSerifHKMedium = await getNotoSerifHKMediumFont();
    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(10),
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.SizedBox(height: 10.0),
            title1(notoSerifHKMedium),
            title2(notoSerifHKMedium),
            pw.SizedBox(width: 10.0, height: 10.0),
            buildDataTable(data, notoSerifHKMedium),
            pw.SizedBox(width: 10.0, height: 10.0),
            UpdateDay(data, notoSerifHKMedium),
          ];
        },
      ),
    );
  }

  pw.Widget title1(pw.Font openSans) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        pw.Text(
          'Output Data',
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(fontSize: 28, font: openSans),
        ),
        pw.Divider(),
      ],
    );
  }

  pw.Widget title2(pw.Font openSans) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        pw.Text(
          'Sensor01',
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(fontSize: 25, font: openSans),
        ),
      ],
    );
  }

  pw.Widget UpdateDay(Map<String, dynamic> data, pw.Font openSans) {
    return pw.Center(
      child: pw.Column(
        children: <pw.Widget>[
          pw.Text("Update Time",
              style: pw.TextStyle(fontSize: 20, font: openSans)),
          pw.Text("Date= ${data["date"]}",
              style: pw.TextStyle(fontSize: 20, font: openSans)),
          pw.Text("Time= ${data["time"]}",
              style: pw.TextStyle(fontSize: 20, font: openSans)),
        ],
      ),
    );
  }

  pw.Widget buildDataTable(Map<String, dynamic> data, pw.Font openSans) {
    return pw.Table(
      columnWidths: const <int, pw.TableColumnWidth>{
        0: pw.FixedColumnWidth(20),
        1: pw.FixedColumnWidth(20),
      },
      border: pw.TableBorder.all(width: 1),
      children: [
        _buildTableRow('感測氣體', '回傳值', openSans),
        _buildTableRow('Temp', '${data["temp"]}', openSans),
        _buildTableRow('Hum', '${data["hum"]}', openSans),
        _buildTableRow('TVOC', '${data["tvoc"]}', openSans),
        _buildTableRow('CO', '${data["co"]}', openSans),
        _buildTableRow('CO2', '${data["co2"]}', openSans),
        _buildTableRow('PM2.5', '${data["pm25"]}', openSans),
        _buildTableRow('O3', '${data["o3"]}', openSans),
      ],
    );
  }

  pw.TableRow _buildTableRow(String label, String value, pw.Font openSans,
      {bool header = false}) {
    return pw.TableRow(
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontSize: 25,
            fontWeight: header ? pw.FontWeight.bold : pw.FontWeight.normal,
            font: openSans,
          ),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(fontSize: 25, font: openSans),
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

class BtnGoBack extends StatelessWidget {
  const BtnGoBack({super.key});

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
