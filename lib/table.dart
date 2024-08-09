class WeddingTable {
  String id;
  final String name;
  final String numberofplaces;

  WeddingTable(
      {this.id = '', required this.name, required this.numberofplaces});

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'numberofplaces': numberofplaces};

  static WeddingTable fromJson(Map<String, dynamic> json) =>
      WeddingTable(name: json['name'], numberofplaces: json['numberofplaces']);
}
