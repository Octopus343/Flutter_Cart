import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final String info;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.info,
  });
}

 List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'Nars',
      amount: 69.99,
      info: 'Radiant Cream',
    ),
    Transaction(
      id: 't2',
      title: 'Huda Beauty',
      amount: 99.53,
      info: 'Legit Lashes',
    ),
    Transaction(
      id: 't3',
      title: 'Kaja',
      amount: 35.99,
      info: 'Creamy Lip',
    ),
    Transaction(
      id: 't4',
      title: 'Glamglow',
      amount: 19.99,
      info: 'Youth Potion',
    ),
    Transaction(
      id: 't5',
      title: 'Verb',
      amount: 25.00,
      info: 'Shampoo',
    ),
    Transaction(
      id: 't6',
      title: 'Moon Juice',
      amount: 35.00,
      info: 'Stress Managment',
    ),
    Transaction(
      id: 't7',
      title: 'Josie Maran',
      amount: 75.99,
      info: 'Cleansing Oil',
    ),
    Transaction(
      id: 't8',
      title: 'Drunk Elephant',
      amount: 25.00,
      info: 'Soap Bar',
    ),
  ];

 