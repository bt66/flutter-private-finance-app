class TransactionType {
  int? id;
  String? name;

  TransactionType({this.id, this.name});

  factory TransactionType.fromMap(Map<String, dynamic> json) => new TransactionType(
    id: json['id'],
    name: json['name']
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name
    };
  }

  
  // static TransactionType fromMap(Map map) {
  //   TransactionType transactionType = new TransactionType();
  //   transactionType.id = map['id'];
  //   transactionType.name = map['name'];
  //   return transactionType;
  // }
}

