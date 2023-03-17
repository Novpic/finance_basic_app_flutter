import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionMovement {

  final String id;
  final String description;
  final DateTime creationDate;
  final double amount;
  final bool income; //if is true is an income if not is expense
  final String? imagePath;
  final double? latitude; // Latitude, in degrees
  final double? longitude; // Longitude, in degrees

  TransactionMovement({
    required this.id,
    required this.description,
    required this.creationDate,
    required this.amount,
    required this.income,
    this.imagePath,
    this.latitude,
    this.longitude,
  });





  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'creationDate': Timestamp.fromDate(creationDate),
      'amount': amount,
      'income': income,
      'imagePath': imagePath,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory TransactionMovement.fromFirestore(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return TransactionMovement(
      id: doc.id,
      description: map['description'] ?? '',
      creationDate: map['creationDate'].toDate(),
      amount: map['amount']?.toDouble() ?? 0.0,
      income: map['income'] ?? false,
      imagePath: map['imagePath'],
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
    );
  }
  

}
