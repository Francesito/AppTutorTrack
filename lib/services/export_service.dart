import 'dart:io';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class ExportService {
  static Future<File> exportPDF(String title, List<List<String>> rows) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (c) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(title, style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 16),
            pw.Table.fromTextArray(data: rows),
          ],
        ),
      ),
    );
    final dir = await getTemporaryDirectory();
    final f = File('${dir.path}/${_ts()}_${_slug(title)}.pdf');
    await f.writeAsBytes(await pdf.save());
    return f;
  }

  static Future<File> exportExcel(String title, List<List<String>> rows) async {
    final ex = Excel.createExcel();
    final sheet = ex['Reporte'];
    for (var r in rows) {
      sheet.appendRow(r);
    }
    final dir = await getTemporaryDirectory();
    final f = File('${dir.path}/${_ts()}_${_slug(title)}.xlsx');
    await f.writeAsBytes(ex.encode()!);
    return f;
  }

  static Future<void> shareFile(File f) async {
    await Share.shareXFiles([XFile(f.path)]);
  }

  static String _ts() => DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
  static String _slug(String s) => s.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_');
}
