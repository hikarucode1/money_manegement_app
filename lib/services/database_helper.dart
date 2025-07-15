import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';
import '../models/transaction.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static sqflite.Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<sqflite.Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<sqflite.Database> _initDatabase() async {
    String path = join(await sqflite.getDatabasesPath(), 'money_management.db');
    return await sqflite.openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(sqflite.Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        amount REAL NOT NULL,
        type TEXT NOT NULL,
        category TEXT NOT NULL,
        date TEXT NOT NULL,
        note TEXT
      )
    ''');
  }

  // 取引を追加
  Future<int> insertTransaction(Transaction transaction) async {
    final db = await database;
    return await db.insert('transactions', transaction.toMap());
  }

  // 全ての取引を取得
  Future<List<Transaction>> getAllTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'transactions',
      orderBy: 'date DESC',
    );
    return List.generate(maps.length, (i) {
      return Transaction.fromMap(maps[i]);
    });
  }

  // 月別の取引を取得
  Future<List<Transaction>> getTransactionsByMonth(String month) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'transactions',
      where: "strftime('%Y-%m', date) = ?",
      whereArgs: [month],
      orderBy: 'date DESC',
    );
    return List.generate(maps.length, (i) {
      return Transaction.fromMap(maps[i]);
    });
  }

  // 取引を更新
  Future<int> updateTransaction(Transaction transaction) async {
    final db = await database;
    return await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  // 取引を削除
  Future<int> deleteTransaction(int id) async {
    final db = await database;
    return await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 月別の収入合計を取得
  Future<double> getMonthlyIncome(String month) async {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT SUM(amount) as total
      FROM transactions
      WHERE strftime('%Y-%m', date) = ? AND type = 'income'
    ''', [month]);
    return result.first['total'] as double? ?? 0.0;
  }

  // 月別の支出合計を取得
  Future<double> getMonthlyExpense(String month) async {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT SUM(amount) as total
      FROM transactions
      WHERE strftime('%Y-%m', date) = ? AND type = 'expense'
    ''', [month]);
    return result.first['total'] as double? ?? 0.0;
  }

  // カテゴリ別の支出を取得
  Future<Map<String, double>> getExpensesByCategory(String month) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT category, SUM(amount) as total
      FROM transactions
      WHERE strftime('%Y-%m', date) = ? AND type = 'expense'
      GROUP BY category
      ORDER BY total DESC
    ''', [month]);

    Map<String, double> categoryExpenses = {};
    for (var row in result) {
      categoryExpenses[row['category'] as String] = row['total'] as double;
    }
    return categoryExpenses;
  }
}
