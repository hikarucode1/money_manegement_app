import 'package:intl/intl.dart';

enum TransactionType {
  income,
  expense,
}

class Transaction {
  final int? id;
  final String title;
  final double amount;
  final TransactionType type;
  final String category;
  final DateTime date;
  final String? note;

  Transaction({
    this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'type': type.name,
      'category': category,
      'date': date.toIso8601String(),
      'note': note,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      type: TransactionType.values.firstWhere(
        (e) => e.name == map['type'],
      ),
      category: map['category'],
      date: DateTime.parse(map['date']),
      note: map['note'],
    );
  }

  String get formattedAmount {
    final formatter = NumberFormat.currency(
      locale: 'ja_JP',
      symbol: '¥',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  String get formattedDate {
    return DateFormat('yyyy/MM/dd').format(date);
  }

  String get formattedMonth {
    return DateFormat('yyyy/MM').format(date);
  }
}
