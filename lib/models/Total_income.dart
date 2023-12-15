class TotalIncomeModel {
  double? ammount;
  String? name;
  TotalIncomeModel({this.ammount, this.name});

  Map<String, dynamic> toMap() {
    return {
      'ammount': ammount,
      'name': name
    };
  }

  static TotalIncomeModel fromMap(Map map) {
    TotalIncomeModel totalIncomeModel = new TotalIncomeModel();
    totalIncomeModel.ammount = map['ammount'];
    totalIncomeModel.name = map['name'];
    // print(totalIncomeModel.ammount);
    return totalIncomeModel;
  }
}