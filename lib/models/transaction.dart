class Transaction {  
  int? id;  
  String title;  
  double amount;  
  String category;  
  DateTime date;  
  bool isIncome;  

  Transaction({  
    this.id,  
    required this.title,  
    required this.amount,  
    required this.category,  
    required this.date,  
    required this.isIncome,  
  });  

  // Konversi ke Map untuk SQLite  
  Map<String, dynamic> toMap() {  
    return {  
      'id': id,  
      'title': title,  
      'amount': amount,  
      'category': category,  
      'date': date.toIso8601String(),  
      'isIncome': isIncome ? 1 : 0,  
    };  
  }  
}  