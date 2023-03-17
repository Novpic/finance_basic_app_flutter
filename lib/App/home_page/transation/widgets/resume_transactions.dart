import 'dart:math';

import 'package:finance_basic_app_flutter/App/home_page/transation/util/currency_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/transaction_movement.dart';
import '../services/stream_transactions_service.dart';

class ResumeTransactions extends ConsumerStatefulWidget {
  final String username;
  const ResumeTransactions({super.key, required this.username});

  @override
  ConsumerState<ResumeTransactions> createState() => _ResumeTransactionsState();
}

//CONTAINS ALL THE WIGDETS POR UPPER BALANCE INFORMATION

class _ResumeTransactionsState extends ConsumerState<ResumeTransactions> {
  

  @override
  Widget build(BuildContext context) {
    final transactions = ref.watch(streamTransactionService);

    return Container(
        padding: const EdgeInsets.all(20),
        height: 200,
        width: double.infinity,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: transactions.when(
                    data: (transactions) {
                      double income = 0;
                      double outcome = 0;
                      double balance = 0;
                      //calculate the income and outcome
                      for(TransactionMovement tr in transactions){
                        if(tr.income){
                          income = income + tr.amount;
                        }else{
                          outcome = outcome + tr.amount;
                        }
                      }

                      // CAlculate the balance and parse the income to a fixed 2 decimals example: 3,30
                      balance = income - outcome;
                      String balanceText = CurrencyInputFormatter.currencyFormater(balance);
                      String incomeText = CurrencyInputFormatter.currencyFormater(income);
                      String outcomeText = CurrencyInputFormatter.currencyFormater(outcome);

                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const DefaultTextStyle(
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                                child: Text('B A L A N C E')),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 10.0)),
                            DefaultTextStyle(
                              style: const TextStyle(
                                fontSize: 40.0,
                                color: Colors.white,
                              ),
                              child: Text(balance >= 0 ? '\$$balanceText': '- \$$balanceText'),
                            ), //here goes the controller caller
                            Container(
                              //padding: const EdgeInsets.only(left:20.0, right: 20.0),

                              //THE INCOME AND AUTCOME ICONS AND TEXT WITH COLOR
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      const Icon(
                                        Icons.arrow_downward,
                                      ),
                                      const DefaultTextStyle(
                                          child: Text('Outcome'),
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black)),
                                      DefaultTextStyle(
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.red[800],
                                              fontWeight: FontWeight.bold),
                                          child: Text('- \$$outcomeText')),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Icon(Icons.arrow_upward),
                                      const DefaultTextStyle(
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black),
                                          child: Text('Income')),
                                      DefaultTextStyle(
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.green[800],
                                              fontWeight: FontWeight.bold),
                                          child: Text('+ \$$incomeText')),
                                    ],
                                  ),
                                  
                                ],
                              ),
                            )
                          ]);
                    },
                    error: (e, t) => Text(e.toString()),
                    loading: () {
                      return Center(
                        child: Container(
                          width: 40,
                          height: 40,
                          child:const CircularProgressIndicator()
                        ),
                      );
                      
                    }))));
  }
}
