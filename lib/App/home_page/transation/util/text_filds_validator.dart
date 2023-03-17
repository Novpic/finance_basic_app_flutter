import 'package:flutter/material.dart';

class TextFieldsValidator{
  
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  bool amountValidator = false;
  bool descriptionValidar = false;
  String amountError = '';
  String descriptionError = '';


  //income and amount verification
    void validatedate(String amount, String description) {

        if (description == '') {
          descriptionError = 'invalid Description';
          descriptionValidar = true;
          descriptionController.text = '';
        } else if (description.length < 2) {
          descriptionError = 'invalid Description';
          descriptionValidar = true;
          descriptionController.text = '';
        } else {
          descriptionValidar = false;
        }

        if (amount == '') {
          amountError = 'invalid Amount';
          amountValidator = true;
          amountController.text = '';
        } else if (amount == '\$0.0') {
          amountError = 'invalid Amount';
          amountValidator = true;
          amountController.text = '';
        } else {
          amountValidator = false;
        }
      }
    

}