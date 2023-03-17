

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogoutService{
   final FirebaseAuth auth = FirebaseAuth.instance;

   Future<void> singOut ()async {
    await FirebaseAuth.instance.signOut();
   }
}

final logOutService = Provider((ref) => LogoutService());