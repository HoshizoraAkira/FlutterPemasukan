import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import '../models/transaction.dart';  
import '../providers/transaction_provider.dart';

class AddTransactionScreen extends StatefulWidget {
  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}


class _AddTransactionScreenState extends State<AddTransactionScreen> {  
  final _formKey = GlobalKey<FormState>();  
  final _titleController = TextEditingController();  
  final _amountController = TextEditingController();  
  String _selectedCategory = 'Makanan';  
  bool _isIncome = false;  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(title: Text('Tambah Transaksi')),  
      body: Padding(  
        padding: const EdgeInsets.all(16.0),  
        child: Form(  
          key: _formKey,  
          child: Column(  
            children: [  
              TextFormField(  
                controller: _titleController,  
                decoration: InputDecoration(labelText: 'Judul'),  
                validator: (value) => value!.isEmpty ? 'Harus diisi' : null,  
              ),  
              TextFormField(  
                controller: _amountController,  
                keyboardType: TextInputType.number,  
                decoration: InputDecoration(labelText: 'Jumlah'),  
                validator: (value) => value!.isEmpty ? 'Harus diisi' : null,  
              ),  
              DropdownButton<String>(  
                value: _selectedCategory,  
                items: ['Makanan', 'Transportasi', 'Gaji', 'Lainnya']  
                    .map((category) => DropdownMenuItem(  
                          value: category,  
                          child: Text(category),  
                        ))  
                    .toList(),  
                onChanged: (value) => _selectedCategory = value!,  
              ),  
              SwitchListTile(  
                title: Text('Pemasukan?'),  
                value: _isIncome,  
                onChanged: (value) {
                  setState(() {
                    _isIncome = value;
                  });
                },
              ),  
              ElevatedButton(  
                onPressed: () {  
                  if (_formKey.currentState!.validate()) {  
                    Transaction transaction = Transaction(  
                      title: _titleController.text,  
                      amount: double.parse(_amountController.text),  
                      category: _selectedCategory,  
                      date: DateTime.now(),  
                      isIncome: _isIncome,  
                    );  
                    Provider.of<TransactionProvider>(context, listen: false)  
                        .addTransaction(transaction);  
                    Navigator.pop(context);  
                  }  
                },  
                child: Text('Simpan'),  
              ),  
            ],  
          ),  
        ),  
      ),  
    );  
  }  
}  