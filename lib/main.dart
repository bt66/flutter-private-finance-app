import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:my_financial_app/database_instance.dart';
import 'package:my_financial_app/models/TotalIncomeModel.dart';
import 'package:my_financial_app/models/TransactionModel.dart';
import 'package:my_financial_app/views/EditUserTransaction.dart';
import 'package:my_financial_app/views/addUserTransaction.dart';
// import 'package:intl/intl.dart' as intl;

void main() {
  runApp(
    const MaterialApp(
      title: 'Financial App',
      debugShowCheckedModeBanner: false,
      home: MainPage(),

    )
  );
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin{
  final List<Tab> month = <Tab>[
    const Tab(text: 'Jan'),
    const Tab(text: 'Feb'),
    const Tab(text: 'Mar'),
    const Tab(text: 'Apr'),
    const Tab(text: 'May'),
    const Tab(text: 'Jun'),
    const Tab(text: 'Jul'),
    const Tab(text: 'Aug'),
    const Tab(text: 'Sept'),
    const Tab(text: 'Oct'),
    const Tab(text: 'Nov'),
    const Tab(text: 'Des'),
  ];

  late TabController _tabController;
  String _dateFilter = DateFormat('MM-yyyy').format(DateTime.now());
  
  List<DropdownMenuItem<String>> _yearsDropdownItems = [];
  final List<String> _yearsFilter =["2022", "2023", "2024", "2025"];
  MoneyFormatter fmf = MoneyFormatter(
    amount: 0,
    settings: MoneyFormatterSettings(
      symbol: 'IDR',
      thousandSeparator: '.',
      decimalSeparator: ',',
      symbolAndNumberSeparator: ' ',
      fractionDigits: 0,
      compactFormatType: CompactFormatType.short
    )
  );
  List<Tab> monthTabMaker() {
    List<Tab> tabs = []; //create an empty list of Tab
    for (var i = 0; i < month.length; i++) {
      tabs.add(month[i]); //add your tabs to the list
    }
    return tabs; //return the list
  }
  @override
  void initState() {
    super.initState();
    _yearsDropdownItems = List.generate(
      _yearsFilter.length, 
      (index) => DropdownMenuItem(
        value: _yearsFilter[index],
        child: Text(_yearsFilter[index]))
    );
    _tabController = TabController(length: month.length, vsync: this, initialIndex: int.parse(DateFormat('MM').format(DateTime.now()))-1)..addListener(() {
      switch(_tabController.index) {
        case 0:
          setState(() {
            _dateFilter = "01-$_selectedYear";
          });
        case 1:
          setState(() {
            _dateFilter = "02-$_selectedYear";
          });
        case 2:
          setState(() {
            _dateFilter = "03-$_selectedYear";
          });
        case 3:
          setState(() {
            _dateFilter = "04-$_selectedYear";
          });
        case 4:
          setState(() {
            _dateFilter = "05-$_selectedYear";
          });

        case 5:
          setState(() {
            _dateFilter = "06-$_selectedYear";
          });
        case 6:
          setState(() {
            _dateFilter = "07-$_selectedYear";
          });

        case 7:
          setState(() {
            _dateFilter = "08-$_selectedYear";
          });
        case 8:
          setState(() {
            _dateFilter = "09-$_selectedYear";
          });
        case 9:
          setState(() {
            _dateFilter = "10-$_selectedYear";
          });
        case 10:
          setState(() {
            _dateFilter = "11-$_selectedYear";
          });
        case 11:
          setState(() {
            _dateFilter = "12-$_selectedYear";
          });
      }
    });
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  String _selectedYear = DateFormat('yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    void refreshData() {
      setState(() {
        
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("My financial App"),
      ),
      body: Column(
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 70,
                    child: FutureBuilder<List<TotalIncomeModel>>(
                    future: DatabaseInstance.db.getIncomeByMonth(_dateFilter),
                    builder: (BuildContext context, AsyncSnapshot<List<TotalIncomeModel>> snapshot) {
                      if(snapshot.hasData) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            TotalIncomeModel item = snapshot.data![index];
                            return ListTile(
                              tileColor: Colors.green,
                              title: Text(
                                "Income this month", 
                                style: TextStyle(
                                  color:Colors.white,fontSize: 20, 
                                  fontWeight: FontWeight.bold
                                  )
                                ),
                              subtitle: Text(
                                '${fmf.copyWith(amount: item.ammount, compactFormatType: CompactFormatType.short).output.symbolOnLeft}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15
                                ),  
                              ),
                            );
                          }
                        );
                      } else {
                        return const Text("no income in this month");
                      }
                    },
                  ),
                  )
                ]
            )
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 70,
                    child: FutureBuilder<List<TotalIncomeModel>>(
                    future: DatabaseInstance.db.getOutcomeByMonth(_dateFilter),
                    builder: (BuildContext context, AsyncSnapshot<List<TotalIncomeModel>> snapshot) {
                      if(snapshot.hasData) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            TotalIncomeModel item = snapshot.data![index];
                            return ListTile(
                              tileColor: Colors.amber,
                              title: Text(
                                "Outcome this month", 
                                style: TextStyle(
                                  color:Colors.white,fontSize: 20, 
                                  fontWeight: FontWeight.bold
                                  )
                                ),
                              subtitle: Text(
                                '${fmf.copyWith(amount: item.ammount, compactFormatType: CompactFormatType.short).output.symbolOnLeft}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15
                                ),  
                              ),
                            );
                          }
                        );
                      } else {
                        return const Text("no income in this month");
                      }
                    },
                  ),
                ) 
              ]
            )
          ),
          DropdownButton(
            items: _yearsDropdownItems,
            value: _selectedYear,
            onChanged: (value) {
              setState(() {
                _selectedYear = value!;
              });
            }
          ),
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: monthTabMaker()
          ),

          Expanded(
            flex: 1,
            child: TabBarView(
              controller: _tabController,
              children: month.map((Tab tab) {
                return FutureBuilder<List<TransactionModel>>(
                  future: DatabaseInstance.db.getTransactionByMonth(_dateFilter),
                  builder: (BuildContext context, AsyncSnapshot<List<TransactionModel>> snapshot) {
                    if(snapshot.hasData) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          TransactionModel item = snapshot.data![index];
                          return ListTile(
                              onLongPress: () {

                              },
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (builder){
                                  return EditUserTransaction(transactionModel: item);
                                })).then((value){
                                  if(value!=null && value) {
                                    refreshData();
                                  }
                                });
                              },
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(DateFormat('d-MM-yyy').format(DateTime.parse(item.date!)))
                                    ],
                                  )
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${fmf.copyWith(amount: item.ammount, compactFormatType: CompactFormatType.short).output.symbolOnLeft}",
                                    style: TextStyle(
                                      color: item.transaction_type_id == 1 ? Colors.red : Colors.green
                                    ),
                                  ),
                                  IconButton(
                                    icon : Icon(Icons.delete, color: Colors.primaries.first),
                                    onPressed: () => {
                                      showAlertDialog(context, item, refreshData)
                                    },
                                  )

                                ],
                              ) 
                            );
                          // Dismissible(
                          //   key: UniqueKey(),
                          //   child: 
                          // );
                        }
                      ); 
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                );
              }).toList()
            )
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (builder){
            return const AddUserTransaction();
          })).then((value){
            if(value!=null && value) {
              refreshData();
            }
          });
        },
      ),

    );
  }
}

showAlertDialog(BuildContext context, data, refreshData) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Delete", style: TextStyle(color: Colors.red),),
    onPressed:  () {
        DatabaseInstance.db.deleteUserTransaction(data.id).then((value) {
        Navigator.of(context).pop(true);
        refreshData();
      });
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content: Text("Would you like to continue delete ${data.name} ?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}