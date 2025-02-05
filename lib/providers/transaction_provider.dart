import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../helpers/database_helper.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  Future<void> loadTransactions() async {
    _transactions = await DatabaseHelper.instance.getAllTransactions();
    notifyListeners();
  }

  Future<void> addTransaction(Transaction transaction) async {
    await DatabaseHelper.instance.insert(transaction);
    await loadTransactions();
  }

  Future<void> deleteTransaction(int id) async {
    await DatabaseHelper.instance.delete(id);
    await loadTransactions();
    notifyListeners();
  }
}
