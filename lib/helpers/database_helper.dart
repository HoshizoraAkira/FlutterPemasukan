import 'package:sqflite/sqflite.dart';  
import 'package:path/path.dart';  
import '../models/transaction.dart' as model_transaction;

class DatabaseHelper {  
  static final _databaseName = 'transactions.db';  
  static final _databaseVersion = 1;  

  static final table = 'transactions';  

  // Kolom tabel  
  static final columnId = 'id';  
  static final columnTitle = 'title';  
  static final columnAmount = 'amount';  
  static final columnCategory = 'category';  
  static final columnDate = 'date';  
  static final columnIsIncome = 'isIncome';  

  // Singleton  
  DatabaseHelper._privateConstructor();  
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();  

  static Database? _database;  
  Future<Database> get database async {  
    if (_database != null) return _database!;  
    _database = await _initDatabase();  
    return _database!;  
  }  

  _initDatabase() async {  
    String path = join(await getDatabasesPath(), _databaseName);  
    return await openDatabase(  
      path,  
      version: _databaseVersion,  
      onCreate: _onCreate,  
    );  
  }  

  Future _onCreate(Database db, int version) async {  
    await db.execute('''  
      CREATE TABLE $table (  
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,  
        $columnTitle TEXT NOT NULL,  
        $columnAmount REAL NOT NULL,  
        $columnCategory TEXT NOT NULL,  
        $columnDate TEXT NOT NULL,  
        $columnIsIncome INTEGER NOT NULL  
      )  
    ''');  
  }  

  // CRUD methods  
  Future<int> insert(model_transaction.Transaction transaction) async {  
    Database db = await instance.database;  
    return await db.insert(table, transaction.toMap());  
  }  

  Future<List<model_transaction.Transaction>> getAllTransactions() async {  
    Database db = await instance.database;  
    List<Map> maps = await db.query(table);  
    return List.generate(maps.length, (i) {  
      return model_transaction.Transaction(  
        id: maps[i]['id'],  
        title: maps[i]['title'],  
        amount: maps[i]['amount'],  
        category: maps[i]['category'],  
        date: DateTime.parse(maps[i]['date']),  
        isIncome: maps[i]['isIncome'] == 1,  
      );  
    });  
  }  

  Future<int> delete(int id) async {  
    Database db = await instance.database;  
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);  
  }  
}  