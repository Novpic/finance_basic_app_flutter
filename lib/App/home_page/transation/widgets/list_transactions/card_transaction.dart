import 'package:finance_basic_app_flutter/App/home_page/transation/widgets/edit_transaction/transaction_editor.dart';
import 'package:flutter/material.dart';

import '../../models/transaction_movement.dart';
import '../../util/currency_input_formatter.dart';
import '../../util/date_formatter.dart';


class CardTranstaction extends StatefulWidget {

  final TransactionMovement transaction;
  const CardTranstaction({
    super.key,
    required this.transaction,
  });


  @override
  State<CardTranstaction> createState() => _CardTranstactionState();
}

class _CardTranstactionState extends State<CardTranstaction> {



   Color decideColor(bool){
      if(bool){
        return Colors.lightGreen;
      }else{
        return Colors.red;
      }
    }
  @override
  Widget build(BuildContext context) {
    bool cardOnHoverColor = false;
    String amountFormated = CurrencyInputFormatter.currencyFormater(widget.transaction.amount); 
    return Padding(
      padding: EdgeInsets.only(bottom: 5,left: 5, right: 5),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context)=> TransactionEditor(transaction: widget.transaction))
          );
          
        },
        child: Card(
            shadowColor: Colors.grey,
            color: Colors.grey[50],
            child:Padding(padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.grey[400]), 
                    child: Icon(Icons.attach_money_sharp),
                  ),
                  Padding(padding: EdgeInsets.only(left: 30)),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          //description text and date
                          children: [
                            DefaultTextStyle(
                              style: TextStyle(color: Colors.black, fontSize: 15), 
                              child: Text(widget.transaction.description)),
                            DefaultTextStyle(
                              style: TextStyle(color: Colors.grey, fontSize: 15,), 
                              child: Text(
                                DateFormatter.dateFormatter(widget.transaction.creationDate)
                                )), 
                  
                            ],
                          ),
                          Spacer(),

                          //Amount format with colors
                          DefaultTextStyle(
                            style: TextStyle(color: decideColor(widget.transaction.income), fontSize: 15, fontWeight: FontWeight.bold), 
                            child: Text(
                              widget.transaction.income ? '+ \$ $amountFormated' :  '- \$ $amountFormated'
                              )) 
                        ],
                    ),
                  ),  
              ],)
            ) 
          ),
        ),
      );  
    
  }
}