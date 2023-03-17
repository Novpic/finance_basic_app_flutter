import 'package:finance_basic_app_flutter/App/home_page/transation/models/transaction_movement.dart';
import 'package:finance_basic_app_flutter/App/home_page/transation/widgets/resume_transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../transation/services/logout_service.dart';
import '../transation/services/stream_transactions_service.dart';
import '../transation/widgets/list_transactions/list_transactions.dart';
import '../transation/widgets/new_transaction/new_transaction_button.dart';
import '../transation/services/transaction_service.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

// THIS WIGDET CONTAINS ALL THE WIDGETS AND A FATHER STACK AND A COLUMN CONTAINING ALL VISIBLE
class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final transactions = ref.watch(streamTransactionService);
    final logoutProvider  = ref.watch(logOutService);

    return Stack(children: [
      //TODO COMPLETE THIS LOGOUT BUTTON
      // Container(
      //   alignment: Alignment.topLeft,
      //   height: 10,
      //   width: 10,
      //   padding: EdgeInsets.all(5),
      //   child: ElevatedButton(
      //     style: ElevatedButton.styleFrom(
      //       shape: CircleBorder(),
      //       backgroundColor: Colors.grey,
      //     ),
      //     onPressed: () {logoutProvider.singOut().then((value) => Navigator.pop(context));},
      //     child: Padding(
      //       padding: const EdgeInsets.all(20.0),
      //       child: Icon(Icons.logout),
      //     )),
      // ),
      
      Container(

        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          //CONTAINS THE RESUME TRANSACTIONS AND THE LIST OF TRANSACTIONS
          children: [
            Padding(padding: EdgeInsets.only(top:20)),
            const ResumeTransactions(username: 'Juan Camilo'),
            SizedBox(height: 5),
            Flexible(child: ListTransactions()),
            SizedBox(height: 5),
          ],
        ),
      ),
      //THIS ARE QUE BOTTOM BAR
      Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              //CONTAINS ALL THE WIGDETS POR THE BOTTOM BAR
              mainAxisAlignment: MainAxisAlignment.center,
              children: [NewTransactrionButton()],
            ),
            Padding(padding: EdgeInsets.only(top: 15))
          ]),
    ]);
  }
}
