import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';

class TransactionListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Transaksi')),
      body: ListView.builder(
        itemCount: provider.transactions.length,
        itemBuilder: (ctx, index) {
          final transaction = provider.transactions[index];
          return ListTile(
            title: Text(transaction.title),
            subtitle: Text(
              '${transaction.amount} - ${transaction.category} - ${DateFormat('dd/MM/yyyy').format(transaction.date)}',
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => provider.deleteTransaction(transaction.id!),
            ),
          );
        },
      ),
    );
  }
}