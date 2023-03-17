

import 'package:finance_basic_app_flutter/App/home_page/transation/services/transaction_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final streamTransactionService = StreamProvider((ref) => ref.read(transactionsServices).allTransactions);