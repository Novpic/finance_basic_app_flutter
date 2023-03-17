import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

import 'package:riverpod/riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_basic_app_flutter/App/home_page/transation/models/transaction_movement.dart';

class DataBaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String colection = 'transaction_movements';

  Stream<List<TransactionMovement>> get allTransactions => _firestore
      .collection(auth.currentUser!.uid)
      .orderBy('creationDate', descending: true)
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (e) => TransactionMovement.fromFirestore(e))
            .toList(),
      );

  Future<void> addTransactionMovement(TransactionMovement transaction) async {
    final uid = auth.currentUser!.uid;
    CollectionReference transactions = _firestore.collection(uid);

    try {
      await transactions.add(transaction.toMap());
      
    } catch (msg) {
      return Future.error(msg);
    }
  }

  Future<bool> removeTranTransactionMovement(
      String transactionMovementId) async {
        final uid = auth.currentUser!.uid;
    CollectionReference transactions = _firestore.collection(uid);

    try {
      await transactions.doc(transactionMovementId).delete();
      return true;
    } catch (msg) {
      print(msg);
      return Future.error(msg);
    }
  }

  
  Future<bool> editTranTransactionMovement(
      String transactionMovementId, TransactionMovement transaction) async {
        final uid = auth.currentUser!.uid;
    CollectionReference transactions = _firestore.collection(uid);

    try {
      await transactions.doc(transactionMovementId).update({
        'description': transaction.description,
        'creationDate': transaction.creationDate,
        'amount': transaction.amount,
        'income': transaction.income,
        'imagePath': transaction.imagePath,
        'latitud': transaction.latitude,
        'longitud': transaction.longitude
      });
      return true;
    } catch (msg) {
      return Future.error(msg);
    }
  }

  
}

final transactionsServices = Provider((ref) => DataBaseService());
