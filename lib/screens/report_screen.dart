import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import '../providers/transaction_provider.dart';  
import '../utils/pdf_export.dart';  

class ReportScreen extends StatelessWidget {  
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
                  SnackBar(content: Text('PDF berhasil diekspor ke folder Download!')),  
                );  
              },  
              child: Text('Ekspor ke PDF'),  
            ),  
            SizedBox(height: 20),  
            ElevatedButton(  
              onPressed: () { /* ... (kode ekspor CSV tetap ada di sini) */ },  
              child: Text('Ekspor ke CSV'),  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}  