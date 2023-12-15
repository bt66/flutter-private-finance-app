import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_financial_app/database_instance.dart';
import 'package:my_financial_app/models/Total_income.dart';
import 'package:my_financial_app/models/TransactionModel.dart';
import 'package:my_financial_app/views/addUserTransaction.dart';
// import 'package:intl/intl.dart' as intl;

void main() {
  runApp(
    const MaterialApp(
      title: 'Financial App',
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
    Tab(text: 'Jan'),
    Tab(text: 'Feb'),
    Tab(text: 'Mar'),
    Tab(text: 'Apr'),
    Tab(text: 'May'),
    Tab(text: 'Jun'),
    Tab(text: 'Jul'),
    Tab(text: 'Aug'),
    Tab(text: 'Sept'),
    Tab(text: 'Oct'),
    Tab(text: 'Nov'),
    Tab(text: 'Des'),
  ];

  late TabController _tabController;
  String _dateFilter = DateFormat('MM-yyyy').format(DateTime.now());
  String _selectedYear = DateFormat('yyyy').format(DateTime.now());
  List<DropdownMenuItem<String>> _yearsDropdownItems = [];
  final List<String> _yearsFilter =["2022", "2023", "2024", "2025"];

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
            _dateFilter = "01-${_selectedYear}";
          });
        case 1:
          setState(() {
            _dateFilter = "02-${_selectedYear}";
          });
        case 2:
          setState(() {
            _dateFilter = "03-${_selectedYear}";
          });
        case 3:
          setState(() {
            _dateFilter = "04-${_selectedYear}";
          });
        case 4:
          setState(() {
            _dateFilter = "05-${_selectedYear}";
          });

        case 5:
          setState(() {
            _dateFilter = "06-${_selectedYear}";
          });
        case 6:
          setState(() {
            _dateFilter = "07-${_selectedYear}";
          });

        case 7:
          setState(() {
            _dateFilter = "08-${_selectedYear}";
          });
        case 8:
          setState(() {
            _dateFilter = "09-${_selectedYear}";
          });
        case 9:
          setState(() {
            _dateFilter = "10-${_selectedYear}";
          });
        case 10:
          setState(() {
            _dateFilter = "11-${_selectedYear}";
          });
        case 11:
          setState(() {
            _dateFilter = "12-${_selectedYear}";
          });
      }
    });
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _refreshData() {
      setState(() {
        
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("My financial App"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 0,
                  color: Colors.green,
                  child: SizedBox(
                    child: Row(
                      children: [
                        Text(
                          "Total Income",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),

                        // FutureBuilder<List<TotalIncomeModel>>(
                        //   future: DatabaseInstance.db.getIncomeByMonth(_dateFilter),
                        //   builder: (BuildContext context, AsyncSnapshot<List<TotalIncomeModel>> snapshot) {
                        //     if(snapshot.hasData) {
                        //       if(snapshot.data!.length == 0) {
                        //         return Center(
                        //           child: Text("No data in this month"),
                        //         );
                        //       } else {
                        //         return ListView.builder(
                        //           physics: BouncingScrollPhysics(),
                        //           itemCount: snapshot.data!.length,
                        //           itemBuilder: (BuildContext context, int index) {
                        //             TotalIncomeModel item = snapshot.data![index];
                        //             return Text("${item.ammount.toString()}");
                        //           }
                        //         );
                        //       }
                        //     } else {
                        //       return Center(child: CircularProgressIndicator());
                        //     }
                        //   },
                        // ),
                      ],
                    ),
                  ),
                )
              ),
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 0,
                  color: Colors.red,
                  child: const SizedBox(
                    child: Row(
                      children: [
                        Text(
                          "Total Outcome",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              ),
              ElevatedButton(onPressed: () => {
                DatabaseInstance.db.getIncomeByMonth(_dateFilter)
              }, child: Text("debug"))
            ],
          ),
          DropdownButton(
            items: _yearsDropdownItems,
            value: _selectedYear,
            onChanged: (value) {
              _selectedYear = value!;
              setState(() {});
            }
          ),
          // start
          Container(
            child: FutureBuilder<List<TotalIncomeModel>>(
              future: DatabaseInstance.db.getIncomeByMonth("12-2023"), 
              builder: (BuildContext context, AsyncSnapshot<List<TotalIncomeModel>> snapshot) {
                if(snapshot.hasData) {
                  if(snapshot.data!.length == 0) {
                    return Center(
                      child: Text("no transaction on this month"),
                    );
                  } else {
                    print("ini data nya ============================================");
                    // print(snapshot.data!.length);
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        TotalIncomeModel itemTransaction = snapshot.data![index];
                        return Dismissible(
                          key: UniqueKey(), 
                          child: Text("${itemTransaction.name}")
                        );
                      },
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }
            ),
          ),

          // done
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: monthTabMaker()
          ),
          // Expanded(
          //   flex: 1,
          //   child: TabBarView(
          //     controller: _tabController,
          //     children: month.map((Tab tab) {
          //       final String label = tab.text!.toLowerCase();
          //         return Expanded(
          //           child: FutureBuilder<List<TransactionModel>>(
          //             future: DatabaseInstance.db.getTransactionByMonth(_dateFilter),
          //             builder: (BuildContext context, AsyncSnapshot<List<TransactionModel>> snapshot) {
          //               if(snapshot.hasData) {
          //                 if(snapshot.data!.length == 0) {
          //                   return Center(
          //                     child: Text("No data in this month"),
          //                   );
          //                 } else {
          //                   return ListView.builder(
          //                     physics: BouncingScrollPhysics(),
          //                     itemCount: snapshot.data!.length,
          //                     itemBuilder: (BuildContext context, int index) {
          //                       TransactionModel item = snapshot.data![index];
          //                       return Dismissible(
          //                         key: UniqueKey(), 
          //                         child: ListTile(
          //                           // title: Text(
          //                           //   item.date!.toString(),
          //                           //   overflow: TextOverflow.ellipsis,
          //                           //   style: const TextStyle(
          //                           //     fontWeight: FontWeight.bold
          //                           //   ),
          //                           // ),
          //                           subtitle: Row(
          //                             mainAxisAlignment: MainAxisAlignment.start,
          //                             crossAxisAlignment: CrossAxisAlignment.center,
          //                             children: [
          //                               // Icon(item.transaction_type_id == 0 ? Icons.add : Icons.maximize_rounded, color: Colors.green),
          //                               Column(
          //                                 mainAxisAlignment: MainAxisAlignment.start,
          //                                 crossAxisAlignment: CrossAxisAlignment.start,
          //                                 children: [
          //                                   Container(
          //                                     child: Text(
          //                                       item.name!,
          //                                       style: const TextStyle(
          //                                         fontWeight: FontWeight.bold
          //                                       ),
          //                                     ),
                                              
          //                                   ),
          //                                   Text(DateFormat('d-MM-yyy').format(DateTime.parse(item.date!)))
          //                                 ],
          //                               )
          //                             ],
          //                           ),
          //                           trailing: Text(
          //                             "${item.transaction_type_id == 1 ? "-" : "+"} Rp.${item.ammount.toString()}",
          //                             style: TextStyle(
          //                               color: item.transaction_type_id == 1 ? Colors.red : Colors.green
          //                             ),
          //                           ),
          //                         )
          //                       );
          //                     }
          //                   );
          //                 }
          //               } else {
          //                 return Center(child: CircularProgressIndicator());
          //               }
          //             },
          //           ),
          //         );
          //       }
          //     ).toList()
          //   )
          // ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (builder){
            return const AddUserTransaction();
          })).then((value){
            if(value!=null && value) {
              _refreshData();
            }
          });
        },
      ),

    );
  }
}