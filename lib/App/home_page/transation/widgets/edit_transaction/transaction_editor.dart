import 'package:file_picker/file_picker.dart';
import 'package:finance_basic_app_flutter/App/home_page/transation/models/transaction_movement.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/image_service.dart';
import '../../services/transaction_service.dart';
import '../../util/currency_input_formatter.dart';
import '../../util/text_filds_validator.dart';
import 'image_download_transaction_editor.dart';

class TransactionEditor extends ConsumerStatefulWidget {
  final TransactionMovement transaction;
  const TransactionEditor({super.key, required this.transaction});

  @override
  ConsumerState<TransactionEditor> createState() => _TransactionEditorState();
}

class _TransactionEditorState extends ConsumerState<TransactionEditor> {
  // bool income verfication
  bool incomeValue = false;
  //verification controllers for amount and description
  TextFieldsValidator textAmountValidator = TextFieldsValidator();

  //file
  FilePickerResult? imageResult;
  String? _fileName;
  Uint8List? pickedfile;
  bool imageAdded = false;
  bool originalImage = false;
  String? downloadedUrl;

  @override
  void initState() {
    if (widget.transaction.imagePath != null) {
      if(widget.transaction.imagePath != ''){
        imageAdded = true;
        originalImage = true;
        print(widget.transaction.imagePath);
      }
    }
    textAmountValidator.amountController.text =
        '\$${CurrencyInputFormatter.currencyFormater(widget.transaction.amount)}';
    textAmountValidator.descriptionController.text =
        widget.transaction.description;
    incomeValue = widget.transaction.income;
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
    final imagedatabase = ref.watch(imageService);
    if(imageAdded && originalImage){
      //delete the next line

      // imagedatabase.downloadImage(widget.transaction.imagePath!).then((value) => setState((){
      //   downloadedUrl = 'https://firebasestorage.googleapis.com/v0/b/finance-flutter-app-87d33.appspot.com/o/images%2FdKPu9Jw2Yeye70fQUAz0.png?alt=media&token=54a286a4-792c-413b-b2e6-62859c045de0';
      // }));
      downloadedUrl = 
      downloadedUrl = 'https://firebasestorage.googleapis.com/v0/b/finance-flutter-app-87d33.appspot.com/o/images%2FdKPu9Jw2Yeye70fQUAz0.png?alt=media&token=54a286a4-792c-413b-b2e6-62859c045de0';

    }
    final database = ref.watch(transactionsServices);
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(padding: EdgeInsets.all(20)),
                // Appbar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor: Colors.grey),
                            onPressed: () => {Navigator.pop(context)},
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            )),
                        const DefaultTextStyle(
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                            child: Text('Edit transaction')),
                      ],
                    ),
                    Spacer(),
                    //save button
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        onPressed: () {
                          setState(() {
                            outcomeButton(database,imagedatabase);
                            Navigator.pop(context);
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DefaultTextStyle(
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            child: Text('Save'),
                          ),
                        )),
                  ],
                ),

                //body
                const Padding(padding: EdgeInsets.all(10)),
                //Income or Outcome Card
                Card(
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DefaultTextStyle(
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                              child:
                                  Text(incomeValue ? ' Income' : ' Outcome')),
                          Switch(
                              value: incomeValue,
                              activeColor: Colors.green,
                              inactiveThumbColor: Colors.red,
                              inactiveTrackColor: Colors.red[200],
                              onChanged: (value) {
                                setState(() {
                                  incomeValue = value;
                                });
                              })
                        ],
                      ),
                    )),

                //Description Card
                Card(
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DefaultTextStyle(
                            style: TextStyle(color: Colors.black, fontSize: 15),
                            child: Text('Description:')),
                        TextField(
                            controller:
                                textAmountValidator.descriptionController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^[-a-zA-Z0-9-() ]*')),
                              FilteringTextInputFormatter.singleLineFormatter
                            ],
                            decoration: InputDecoration(
                                hintText: 'Write something',
                                errorText:
                                    textAmountValidator.descriptionValidar
                                        ? textAmountValidator.descriptionError
                                        : null,
                                helperText: widget.transaction.description,
                                fillColor: Colors.white,
                                filled: true))
                      ],
                    ),
                  ),
                ),

                //Amount Card
                Card(
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DefaultTextStyle(
                            style: TextStyle(color: Colors.black, fontSize: 15),
                            child: Text('Amount:')),
                        TextField(
                            controller: textAmountValidator.amountController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyInputFormatter()
                            ],
                            decoration: InputDecoration(
                                hintText:
                                    CurrencyInputFormatter.currencyFormater(
                                        widget.transaction.amount),
                                errorText: textAmountValidator.amountValidator
                                    ? textAmountValidator.amountError
                                    : null,
                                helperText:
                                    CurrencyInputFormatter.currencyFormater(
                                        widget.transaction.amount),
                                fillColor: Colors.white,
                                filled: true))
                      ],
                    ),
                  ),
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Photo file
                    Card(
                        color: Colors.grey[100],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const DefaultTextStyle(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  child: Text('Photo:')),

                              //Photo container
                              Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: MediaQuery.of(context).size.width / 3,
                                  padding: const EdgeInsets.all(5),
                                  child:
                                  ElevatedButton(
                                          onPressed: pickFile,
                                          //Image.network('https://firebasestorage.googleapis.com/v0/b/finance-flutter-app-87d33.appspot.com/o/images%2FdKPu9Jw2Yeye70fQUAz0.png?alt=media&token=54a286a4-792c-413b-b2e6-62859c045de0'):Image.memory(pickedfile!,fit: BoxFit.fill)
                                              
                                          child: (imageAdded)?
                                              (originalImage)? ImageDownloadTransactionEditos(path:widget.transaction.imagePath!) :Image.memory(pickedfile!)
                                              :Icon(Icons.image_search_outlined)
                                       )
                                   ),
                            ],
                          ),
                        )),
                    const Padding(padding: EdgeInsets.all(5)),

                    //Location file
                    Card(
                        color: Colors.grey[100],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const DefaultTextStyle(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  child: Text('Location:')),
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.width / 3,
                                padding: const EdgeInsets.all(5),
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Icon(Icons.location_pin)),
                              ),
                            ],
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
  

  String getDesccriptionRegex(String description) {
    description = description.replaceAll(RegExp(r'^\s+|\s+$'), '');
    return description;
  }

  double getAmountRegex(String amount) {
    String amountfinal = amount.replaceAll(RegExp(r'[^0-9]'), '');
    return double.parse(amountfinal) / 10;
  }

  //image picker

  void pickFile() async {
    try {
      imageResult = await FilePicker.platform
          .pickFiles(type: FileType.image, withData: true);

      if (imageResult != null) {
        _fileName = imageResult!.files.first.extension;
        pickedfile = imageResult!.files.first.bytes;
        originalImage = false;
        setState(() {
          imageAdded = true;
          
        });
        
      }
    } catch (err) {

    }
  }

  //TODO FINISH THIS FUNCTION TO UPDATE CORRECTLY
  Future<void> outcomeButton(DataBaseService db, ImageService dbImage) async {
    String amountText = textAmountValidator.amountController.text;
    String descriptionText = textAmountValidator.descriptionController.text;
    String? path;


    setState(() {
      textAmountValidator.validatedate(amountText, descriptionText);
    });
    

    if (!textAmountValidator.descriptionValidar &&
        !textAmountValidator.amountValidator) {
      descriptionText = getDesccriptionRegex(descriptionText);
      double finalAmount = getAmountRegex(amountText);
      String? urlDownload;

      if(imageAdded){
        path='${widget.transaction.id}.$_fileName';

        if(!originalImage){
          urlDownload = await dbImage.uploadImage(path,pickedfile!);
          print(urlDownload);
          print('aca esta el error inside after');
        }
      } 

     TransactionMovement newTransaction = TransactionMovement(
          id: '',
          description: descriptionText,
          creationDate: widget.transaction.creationDate,
          amount: finalAmount,
          imagePath: path,
          income: widget.transaction.income);

      print(newTransaction.toMap());
      await db.editTranTransactionMovement(widget.transaction.id,newTransaction);
    }
  }
}
    //function for verification

    

    
  //save funtion + verification
  
