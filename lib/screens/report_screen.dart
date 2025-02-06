import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pencatatan_keuangan_2/utils/csv_export.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../utils/pdf_export.dart';

class ReportScreen extends StatelessWidget {
  Future<void> _exportToCsv(BuildContext context) async {
    final provider = Provider.of<TransactionProvider>(context, listen: false);
    final csvData = generateCsv(provider.transactions);

    final directory = await getDownloadsDirectory();
    final file = File('${directory?.path}/laporan_keuangan.csv');
    await file.writeAsString(csvData);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('CSV disimpan di: ${file.path}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Laporan Keuangan')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await generatePdf(provider.transactions);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Text('PDF berhasil diekspor ke folder Download!')),
                );
              },
              child: Text('Ekspor ke PDF'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _exportToCsv(context),
              child: Text('Ekspor ke CSV'),
            ),
          ],
        ),
      ),
    );
  }
}
