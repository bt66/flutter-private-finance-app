import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_financial_app/database_instance.dart';
import 'package:my_financial_app/models/TransactionModel.dart';

// import 'package:my_financial_app/models/Transaction_type.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EditUserTransaction extends StatefulWidget {
  TransactionModel transactionModel;
  EditUserTransaction({super.key, required this.transactionModel});

  @override
  State<EditUserTransaction> createState() => _EditUserTransactionState();
}

class _EditUserTransactionState extends State<EditUserTransaction> {
  static TransactionModel transactionModel = TransactionModel();

  // late String initialNameField = transactionModel.name!;

  TextEditingController nameFieldController = TextEditingController();
  TextEditingController descriptionFieldController = TextEditingController();
  TextEditingController ammountFieldController = TextEditingController();
  DateTime _date = new DateTime.now();
  int _transaction_type = 0;

  void initState() {
    nameFieldController.text = widget.transactionModel.name ?? "";
    descriptionFieldController.text = widget.transactionModel.description ?? "";
    ammountFieldController.text = widget.transactionModel.ammount.toString() ?? "";
    _transaction_type = widget.transactionModel.transaction_type_id ?? 0;
    _date = DateTime.parse(widget.transactionModel.date!) ?? new DateTime.now();
    super.initState();
  }
  
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    print(args.value);
  }
  void _showDatePicker() {
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2020), 
      lastDate: DateTime(2035)
    ).then((value) => {
      setState(() {
        _date = value!;
      })
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit User Transaction"),
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: nameFieldController,
              decoration: InputDecoration(
                icon: const Icon(Icons.add_shopping_cart),
                hintText: "Your transaction name",
                labelText: "Name: *",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                contentPadding: EdgeInsets.all(20.0)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              controller: descriptionFieldController,
              
              decoration: InputDecoration(
                icon: Icon(Icons.description),
                hintText: "A description about your transaction",
                labelText: "Description: ",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                contentPadding: EdgeInsets.all(20.0)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              controller: ammountFieldController,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                icon: Icon(Icons.money),
                hintText: "Ammount of your transaction",
                labelText: "Ammount: *",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                contentPadding: EdgeInsets.all(20.0)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListTile(
                  title: const Text("Income"),
                  leading: Radio(
                    value: 2,
                    groupValue: _transaction_type,
                    onChanged: (value) {
                      setState(() {
                        _transaction_type = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text("Outcome"),
                  leading: Radio(
                    value: 1,
                    groupValue: _transaction_type,
                    onChanged: (value) {
                      setState(() {
                        _transaction_type = value!;
                      });
                    },
                  ),
                )
              ],
            )
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showDatePicker();
                  }, 
                  child: Text("Pick date")
                ),
                Text(_date.toString()),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async{
              await DatabaseInstance.db.updateUserTransaction(
                widget.transactionModel!.id!,
                {
                  'name' : nameFieldController.text,
                  'description' : descriptionFieldController.text,
                  'ammount': ammountFieldController.text,
                  'date': _date.toString(),
                  'transaction_type_id': _transaction_type
                }
              );
              Navigator.of(context).pop(true);
            }, 
            child: Text("Update") 
          )
          // Container(
          //   child: SfDateRangePicker(
          //     onSelectionChanged: _onSelectionChanged,
          //     selectionMode: DateRangePickerSelectionMode.single,
          //   ),
          // )
          
        ],
        )
      )
      
    ); 
  }
}