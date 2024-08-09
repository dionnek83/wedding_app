import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wedding_app/guest.dart';
import 'package:wedding_app/table.dart';

class Guests extends StatefulWidget {
  const Guests({super.key});

  @override
  State<Guests> createState() => _GuestsState();
}

class _GuestsState extends State<Guests> {
  bool ischecked = false;

  List<String> tableOptions = [];
  String couple = "";
  String? valueChoose;

  final _fullname = TextEditingController();
  final _phonenumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayTables();
  }

  Future<void> displayTables() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('tables').get();
      List<String> fetchedOptions =
          snapshot.docs.map((doc) => doc['name'] as String).toList();
      setState(() {
        tableOptions = fetchedOptions;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: null,
          title: const Text(
            'Our Guests',
            style: TextStyle(color: Colors.white),
          ),
          // elevation: 0.00,
          backgroundColor: const Color(0xFFE68369),
          centerTitle: true,
          toolbarHeight: 70.2,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.person_add_alt_1_rounded),
              iconSize: 30,
              color: Colors.white,
              onPressed: () {
                openAddGuestForm();
              },
            ),
            IconButton(
              icon: const Icon(Icons.add_box_rounded),
              iconSize: 30,
              color: Colors.white,
              onPressed: () {
                //openAddTableForm();
              },
            ), //IconButton
            //IconButton
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 40, left: 30),
            child: Column(children: [
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[30],
                          contentPadding: const EdgeInsets.all(15.0),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.shade100, width: 2),
                              borderRadius: BorderRadius.circular(20.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFFFA8072), width: 2),
                              borderRadius: BorderRadius.circular(20.0)),
                          hintText: 'Search Guests',
                          hintStyle: TextStyle(color: Colors.grey[350]),
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.close, color: Colors.grey[350])),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[350],
                          )))),
              getGuests()
            ])));
  }

  Future openAddGuestForm() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Add Guest"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _fullname,
                  decoration: const InputDecoration(
                      hintText: "Enter guest's full name"),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _phonenumber,
                  decoration:
                      const InputDecoration(hintText: 'Enter phone number'),
                ),
                const SizedBox(height: 5),
                Row(children: <Widget>[
                  Checkbox(
                    value: ischecked,
                    onChanged: (bool? value) {
                      setState(() {
                        ischecked = value!;
                      });
                    },
                    checkColor: Colors.black,
                    activeColor: const Color(0xFFE68369),
                  ),
                  const Text("Couple?",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 15)),
                ]),
                const SizedBox(height: 5),
                DropdownButton(
                  hint: const Text("Select Table"),
                  items: tableOptions.map((valueItem) {
                    return DropdownMenuItem<String>(
                        value: valueItem, child: Text(valueItem));
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      valueChoose = newValue.toString();
                    });
                  },
                  value: valueChoose,
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    final fullname = _fullname.text;
                    final phonenumber = _phonenumber.text;

                    if (ischecked == true) {
                      couple = "true";
                    } else {
                      couple = 'false';
                    }
                    final table = valueChoose;

                    createGuest(
                        fullname: fullname,
                        phonenumber: phonenumber,
                        couple: couple,
                        table: table.toString());
                  },
                  child: Center(
                      child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xFFE68369)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: const Text(
                      'Submit',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ))),
            ],
          ));
}

Future createGuest(
    {required String fullname,
    required String phonenumber,
    required String couple,
    required String table}) async {
  final guestDoc = FirebaseFirestore.instance.collection('guests').doc();

  final guest = Guest(
      id: guestDoc.id,
      fullname: fullname,
      phonenumber: phonenumber,
      couple: couple,
      table: table);
  final data = guest.toJson();
  await guestDoc.set(data);
}

Stream<List<WeddingTable>> readTables() =>
    FirebaseFirestore.instance.collection('tables').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => WeddingTable.fromJson(doc.data()))
          .toList();
    });

Stream<List<Guest>> readGuests() =>
    FirebaseFirestore.instance.collection('guests').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Guest.fromJson(doc.data())).toList();
    });

Widget getGuests() {
  return StreamBuilder<List<Guest>>(
      stream: readGuests(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(children: [
                CircularProgressIndicator(color: Color(0xFFFA8072)),
              ]));
        } else if (snapshot.data!.isNotEmpty) {
          final guests = snapshot.data!;

          return Flexible(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15.0),
                  child: ListView.builder(
                      itemCount: guests.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFFE68369),
                            radius: 20.0,
                            child: Icon(
                              Icons.person_2_outlined,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(guests[index].fullname),
                          subtitle: Text("Table: ${guests[index].table}"),
                          trailing: const Icon(Icons.more_vert),
                        ));
                      })));
        }

        return const Text('Hello');
      });
}
