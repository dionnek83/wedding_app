class Guest {
  String id;
  final String fullname;
  final String phonenumber;
  final String couple;
  final String table;

  Guest(
      {this.id = '',
      required this.fullname,
      required this.phonenumber,
      required this.couple,
      required this.table});

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullname': fullname,
        'phonenumber': phonenumber,
        'couple': couple,
        'table': table
      };

  static Guest fromJson(Map<String, dynamic> json) => Guest(
      fullname: json['fullname'],
      phonenumber: json['phonenumber'],
      couple: json['couple'],
      table: json['table']);
}
