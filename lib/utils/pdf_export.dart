import 'dart:io';  
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  
import 'package:path_provider/path_provider.dart';  
import 'package:syncfusion_flutter_pdf/pdf.dart';  
import '../models/transaction.dart';  

Future<void> generatePdf(List<Transaction> transactions) async {  
  // Buat dokumen PDF  
  final PdfDocument document = PdfDocument();  

  // Tambahkan halaman  
  final PdfPage page = document.pages.add();  
  final PdfGraphics graphics = page.graphics;  

  // Judul Laporan  
  final PdfFont titleFont = PdfStandardFont(PdfFontFamily.helvetica, 18);  
  graphics.drawString(  
    'Laporan Keuangan',  
    titleFont,  
    brush: PdfSolidBrush(PdfColor(0, 0, 0)),  
    bounds: Rect.fromLTWH(0, 20, page.getClientSize().width, 30),  
    format: PdfStringFormat(alignment: PdfTextAlignment.center),  
  );  

  // Buat tabel  
  final PdfGrid grid = PdfGrid();  
  grid.columns.add(count: 5);  
  grid.headers.add(1);  

  // Header Tabel  
  PdfGridRow header = grid.headers[0];  
  header.cells[0].value = 'Judul';  
  header.cells[1].value = 'Jumlah';  
  header.cells[2].value = 'Kategori';  
  header.cells[3].value = 'Tanggal';  
  header.cells[4].value = 'Jenis';  

  // Isi Tabel  
  for (var transaction in transactions) {  
    PdfGridRow row = grid.rows.add();  
    row.cells[0].value = transaction.title;  
    row.cells[1].value = transaction.amount.toString();  
    row.cells[2].value = transaction.category;  
    row.cells[3].value = DateFormat('dd-MM-yyyy').format(transaction.date);  
    row.cells[4].value = transaction.isIncome ? 'Pemasukan' : 'Pengeluaran';  
  }  

  // Style Tabel  
  grid.style = PdfGridStyle(  
    cellPadding: PdfPaddings(left: 5, right: 5, top: 5, bottom: 5),  
    font: PdfStandardFont(PdfFontFamily.helvetica, 12),  
  );  

  // Gambar tabel ke halaman PDF  
  grid.draw(  
    page: page,  
    bounds: Rect.fromLTWH(  
      0,  
      60,  
      page.getClientSize().width,  
      page.getClientSize().height,  
    ),  
  );  

  // Simpan file PDF  
  final Directory? directory = await getDownloadsDirectory();  
  final File file = File('${directory!.path}/laporan_keuangan.pdf');  
  await file.writeAsBytes(await document.save());  

  // Tutup dokumen  
  document.dispose();  
}  