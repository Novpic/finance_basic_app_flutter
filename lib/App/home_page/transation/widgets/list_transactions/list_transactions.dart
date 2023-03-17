import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/transaction_movement.dart';
import 'package:intl/intl.dart';

import '../../services/stream_transactions_service.dart';
import 'card_transaction.dart';

class ListTransactions extends ConsumerStatefulWidget {
  ListTransactions({super.key});

  @override
  ConsumerState<ListTransactions> createState() => _ListTransactionsState();
}

class _ListTransactionsState extends ConsumerState<ListTransactions> {
  @override
  void initState() {
    //createTransaction();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final transactions = ref.watch(streamTransactionService);
    return transactions.when(
        data: (transactions) {
          return Container(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: transactions
                    .length, //TODO change to the lenght of Transactions
                itemBuilder: (context, index) {
                  return CardTranstaction(transaction: transactions[index]);
                }),
          );
        },
        error: (e, t) => Text(e.toString()),
        loading: () {
          return CircularProgressIndicator();
        });
  }
}
