import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import 'screens/dashboard_screen.dart';  
import 'providers/transaction_provider.dart';  

void main() {  
  runApp(  
    ChangeNotifierProvider(  
      create: (context) => TransactionProvider()..loadTransactions(),  
      child: MyApp(),  
    ),  
  );  
}  

class MyApp extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      title: 'Catatan Keuangan',  
      home: DashboardScreen(),  
    );  
  }  
}  