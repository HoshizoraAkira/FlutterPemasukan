import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_pencatatan_keuangan_2/screens/add_transaction_screen.dart';
import 'package:flutter_pencatatan_keuangan_2/screens/report_screen.dart';
import 'package:flutter_pencatatan_keuangan_2/screens/transaction_list_screen.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    double totalIncome = provider.transactions
        .where((t) => t.isIncome)
        .fold(0, (sum, t) => sum + t.amount);
    double totalExpense = provider.transactions
        .where((t) => !t.isIncome)
        .fold(0, (sum, t) => sum + t.amount);

    // Data untuk grafik
    final List<PieChartSectionData> chartSections = [
      PieChartSectionData(
        color: Colors.green,
        value: totalIncome,
        title: 'Pemasukan\n${totalIncome.toStringAsFixed(2)}',
        radius: 60,
        titleStyle: TextStyle(color: Colors.white, fontSize: 12),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: totalExpense,
        title: 'Pengeluaran\n${totalExpense.toStringAsFixed(2)}',
        radius: 60,
        titleStyle: TextStyle(color: Colors.white, fontSize: 12),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'SaldoX: ${(totalIncome - totalExpense).toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sections: chartSections,
                centerSpaceRadius: 40,
                sectionsSpace: 2,
                startDegreeOffset: 180,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTransactionScreen()),
              );
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TransactionListScreen()),
              );
            },
            child: Icon(Icons.list),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: null,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReportScreen()),
            ),
            child: Icon(Icons.picture_as_pdf),
          ),
        ],
      ),
    );
  }
}
