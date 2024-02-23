import 'package:flutter/material.dart';
import 'package:my_financial_app/database_instance.dart';
import 'package:my_financial_app/models/Transaction_type.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class EditPerson extends StatefulWidget {
  const EditPerson({super.key});

  @override
  State<EditPerson> createState() => _EditPersonState();
}

class _EditPersonState extends State<EditPerson> {
  TextEditingController nameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add data"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: nameEditingController,
            decoration: InputDecoration(
              icon: Icon(Icons.nature),
              hintText: "Name",
              labelText: "Name: ",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
            ),
          ),
          ElevatedButton(
            onPressed: () async{
              await DatabaseInstance.db.addTransactionType(
                new TransactionType(
                  name: nameEditingController.text
                )
              );
              Navigator.pop(context);
            }, 
            child: Center(
              child: Text("Submit"),
            )
          ),
        ],
      ),
    );
  }
}