import 'package:flutter/material.dart';
import 'package:my_financial_app/database_instance.dart';
import 'package:my_financial_app/models/TotalIncomeModel.dart';

class TotalIncome extends StatefulWidget {
  const TotalIncome({super.key});

  @override
  State<TotalIncome> createState() => _TotalIncomeState();
}

class _TotalIncomeState extends State<TotalIncome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('total income'),
      ),
      body: Container(
        child: FutureBuilder<List<TotalIncomeModel>>(
          future: DatabaseInstance.db.getIncomeByMonth("12-2023"),
          builder: (BuildContext context, AsyncSnapshot<List<TotalIncomeModel>> snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  TotalIncomeModel item = snapshot.data![index];
                  return Text("${item.ammount.toString()}");
                }
              );
            } else {
              return Text("hehe");
            }
          },
        )
      ),
    );
  }
}