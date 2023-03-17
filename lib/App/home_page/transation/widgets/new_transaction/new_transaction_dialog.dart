import 'package:finance_basic_app_flutter/App/home_page/transation/models/transaction_movement.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/transaction_service.dart';
import '../../util/currency_input_formatter.dart';
import '../../util/text_filds_validator.dart';

class NewTransactionDialog extends ConsumerStatefulWidget {
  const NewTransactionDialog({super.key});

  @override
  ConsumerState<NewTransactionDialog> createState() =>
      _NewTransactionDialogState();
}

class _NewTransactionDialogState extends ConsumerState<NewTransactionDialog> {

  TextFieldsValidator textAmountValidator = TextFieldsValidator();


  @override
  Widget build(BuildContext context) {
    final database = ref.watch(transactionsServices);
    
   

    return AlertDialog(
      title: const Text('NEW TRANSACTION'),
      content: Container(
        height: MediaQuery.of(context).size.height / 3 + 80,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Description:', style: TextStyle(fontSize: 20)),
              TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^[-a-zA-Z0-9-() ]*')),
                  FilteringTextInputFormatter.singleLineFormatter
                ],
                controller: textAmountValidator.descriptionController,
                decoration: InputDecoration(
                    hintText: 'Write something',
                    errorText: textAmountValidator.descriptionValidar ? textAmountValidator.descriptionError : null,
                    helperText: 'food, sells, salary'),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              const Text('Amount:', style: TextStyle(fontSize: 20)),
              TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    // Fit the validating format.
                    //fazer o formater para dinheiro
                    CurrencyInputFormatter()
                  ],
                  controller: textAmountValidator.amountController,
                  decoration: InputDecoration(
                      hintText: '\$31.20',
                      errorText: textAmountValidator.amountValidator ? textAmountValidator.amountError : null,
                      helperText: 'insert amount')),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () => outcomeButton(database).then((value){
                              (!textAmountValidator.descriptionValidar && !textAmountValidator.amountValidator)?Navigator.of(context).pop():null ;
                            } ),
                          child: const Text('Outcome'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red)),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: () => incomeButton(database).then(
                            (value){
                              (!textAmountValidator.descriptionValidar && !textAmountValidator.amountValidator)?Navigator.of(context).pop():null ;
                            } ),
                          child: const Text('Income'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green)),
                      
                      
                    ],
                  )),
            ]),
      ),
    );
  }

  Future<void> incomeButton(DataBaseService db) async {
    String amountText = textAmountValidator.amountController.text;
    String descriptionText = textAmountValidator.descriptionController.text;

    setState(() {
      textAmountValidator.validatedate(amountText, descriptionText);
    });

    if (!textAmountValidator.descriptionValidar && !textAmountValidator.amountValidator) {
      descriptionText = getDesccriptionRegex(descriptionText);
      double finalAmount = getAmountRegex(amountText);

      TransactionMovement transaction = TransactionMovement(
          id: '',
          description: descriptionText,
          creationDate: DateTime.now(),
          amount: finalAmount,
          income: true);

      await db.addTransactionMovement(transaction);
      

    }
  }

  Future<void> outcomeButton(DataBaseService db) async {
    String amountText = textAmountValidator.amountController.text;
    String descriptionText = textAmountValidator.descriptionController.text;

    setState(() {
      textAmountValidator.validatedate(amountText, descriptionText);
    });

    if (!textAmountValidator.descriptionValidar && !textAmountValidator.amountValidator) {
      descriptionText = getDesccriptionRegex(descriptionText);
      double finalAmount = getAmountRegex(amountText);

      TransactionMovement transaction = TransactionMovement(
          id: '',
          description: descriptionText,
          creationDate: DateTime.now(),
          amount: finalAmount,
          income: false);

      await db.addTransactionMovement(transaction);
      

    }
  }

  String getDesccriptionRegex(String description) {
    description = description.replaceAll(RegExp(r'^\s+|\s+$'), '');

    return description;
  }

  double getAmountRegex(String amount) {
    String amountfinal = amount.replaceAll(RegExp(r'[^0-9]'), '');


    return double.parse(amountfinal)/10;
  }
}
