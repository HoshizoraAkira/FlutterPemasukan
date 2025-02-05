import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

String generateCsv(List<Transaction> transactions) {
  final List<List<dynamic>> csvData = [
    ['Judul', 'Jumlah', 'Kategori', 'Tanggal', 'Jenis'], // Header CSV
  ];

  for (var transaction in transactions) {
    csvData.add([
      transaction.title,
      transaction.amount,
      transaction.category,
      DateFormat('dd-MM-yyyy').format(transaction.date),
      transaction.isIncome ? 'Pemasukan' : 'Pengeluaran',
    ]);
  }

  return const ListToCsvConverter().convert(csvData);
}