import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import '../services/database_helper.dart';

class TransactionProvider with ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Transaction> _transactions = [];
  String _currentMonth = DateFormat('yyyy-MM').format(DateTime.now());
  double _monthlyIncome = 0.0;
  double _monthlyExpense = 0.0;
  Map<String, double> _categoryExpenses = {};

  List<Transaction> get transactions => _transactions;
  String get currentMonth => _currentMonth;
  double get monthlyIncome => _monthlyIncome;
  double get monthlyExpense => _monthlyExpense;
  Map<String, double> get categoryExpenses => _categoryExpenses;
  double get monthlyBalance => _monthlyIncome - _monthlyExpense;

  // 月を変更
  void setMonth(String month) {
    _currentMonth = month;
    loadTransactions();
  }

  // 取引を追加
  Future<void> addTransaction(Transaction transaction) async {
    await _databaseHelper.insertTransaction(transaction);
    await loadTransactions();
  }

  // 取引を更新
  Future<void> updateTransaction(Transaction transaction) async {
    await _databaseHelper.updateTransaction(transaction);
    await loadTransactions();
  }

  // 取引を削除
  Future<void> deleteTransaction(int id) async {
    await _databaseHelper.deleteTransaction(id);
    await loadTransactions();
  }

  // 取引データを読み込み
  Future<void> loadTransactions() async {
    _transactions = await _databaseHelper.getTransactionsByMonth(_currentMonth);
    _monthlyIncome = await _databaseHelper.getMonthlyIncome(_currentMonth);
    _monthlyExpense = await _databaseHelper.getMonthlyExpense(_currentMonth);
    _categoryExpenses =
        await _databaseHelper.getExpensesByCategory(_currentMonth);
    notifyListeners();
  }

  // 全ての取引を読み込み
  Future<void> loadAllTransactions() async {
    _transactions = await _databaseHelper.getAllTransactions();
    notifyListeners();
  }

  // カテゴリリストを取得
  List<String> get categories {
    Set<String> categories = {};
    for (var transaction in _transactions) {
      categories.add(transaction.category);
    }
    return categories.toList()..sort();
  }

  // 収入カテゴリ
  static const List<String> incomeCategories = [
    '給料',
    'ボーナス',
    '副業',
    '投資',
    'その他収入',
  ];

  // 支出カテゴリ
  static const List<String> expenseCategories = [
    '食費',
    '住居費',
    '光熱費',
    '通信費',
    '交通費',
    '医療費',
    '教育費',
    '娯楽費',
    '衣服費',
    'その他支出',
  ];
}
