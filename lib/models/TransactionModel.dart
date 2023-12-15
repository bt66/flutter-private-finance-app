class TransactionModel {
  int? id;
  int? transaction_type_id;
  String? name;
  String? description;
  double? ammount;
  String? date;
  TransactionModel({this.id, this.transaction_type_id, this.name, this.description, this.ammount, this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transaction_type_id': transaction_type_id,
      'name': name,
      'description': description,
      'ammount': ammount,
      "date": date,
    };
  }

  static TransactionModel fromMap(Map map) {
    TransactionModel transactionModel = new TransactionModel();
    transactionModel.id = map['id'];
    transactionModel.transaction_type_id = map['transaction_type_id'];
    transactionModel.name = map['name'];
    transactionModel.description = map['description'];
    transactionModel.ammount = map['ammount'];
    transactionModel.date = map['date'];
    return transactionModel;
  }
}


