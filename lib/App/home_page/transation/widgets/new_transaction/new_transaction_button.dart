import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'new_transaction_dialog.dart';


class NewTransactrionButton extends ConsumerStatefulWidget {
  const NewTransactrionButton({super.key});

  @override
  ConsumerState<NewTransactrionButton> createState() => _NewTransactrionButtonState();
}
//BUTTON FOR A NEW TRANSACTION
class _NewTransactrionButtonState extends ConsumerState<NewTransactrionButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        backgroundColor: Colors.grey,
        
        
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child:Icon(Icons.add)
        ), 
      onPressed: (){
        //ALERTDIALOG VIEW
        showDialog(
          context: context,
          builder: (context){
            return NewTransactionDialog();
          });
      },
      onLongPress: (){
        //TODO create new window with all the funtionalities
      },
    );
  }

  
}

//LOGIC TO GET THE AMOUT TEXT FILD UPDATED
