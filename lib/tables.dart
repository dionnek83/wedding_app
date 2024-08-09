import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wedding_app/table.dart';

class Tables extends StatefulWidget {
  const Tables({super.key});

  @override
  State<Tables> createState() => _Tables();
}

class _Tables extends State<Tables> {
  final _name = TextEditingController();
  final _number_of_places = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: null,
          title: const Text(
            'Tables',
            style: TextStyle(color: Colors.white),
          ),
          // elevation: 0.00,
          backgroundColor: const Color(0xFFE68369),
          centerTitle: true,
          toolbarHeight: 70.2,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_box_rounded),
              iconSize: 45,
              color: Colors.white,
              onPressed: () {
                openAddTableForm();
              },
            ), //IconButton
            //IconButton
          ],
        ),
        body: Column(children: [getTables()]));
  }

  Future openAddTableForm() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Add Table"),
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              TextField(
                controller: _name,
                decoration: const InputDecoration(hintText: 'Enter table name'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _number_of_places,
                decoration:
                    const InputDecoration(hintText: 'Enter number of places'),
              )
            ]),
            actions: [
              TextButton(
                  onPressed: () {
                    final name = _name.text;
                    final numberofplaces = _number_of_places.text;

                    createTable(name: name, numberofplaces: numberofplaces);
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
                      // style: GoogleFonts.jetBrainsMono(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ))),
            ],
          ));

  Stream<List<WeddingTable>> readTables() => FirebaseFirestore.instance
          .collection('tables')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => WeddingTable.fromJson(doc.data()))
            .toList();
      });

  Future createTable(
      {required String name, required String numberofplaces}) async {
    final tableDoc = FirebaseFirestore.instance.collection('tables').doc();

    final table = WeddingTable(
        id: tableDoc.id, name: name, numberofplaces: numberofplaces);
    final data = table.toJson();
    await tableDoc.set(data);
  }

  Widget getTables() {
    return StreamBuilder<List<WeddingTable>>(
        stream: readTables(),
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
            final tables = snapshot.data!;

            return Flexible(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 15.0),
                    child: ListView.builder(
                        itemCount: tables.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xFFE68369),
                              radius: 20.0, // Adjust the radius as needed
                              backgroundImage:
                                  AssetImage('assets/tableicon.png'),
                            ),
                            title: Text(tables[index].name),
                            subtitle:
                                Text("${tables[index].numberofplaces} places"),
                            trailing: const Icon(Icons.more_vert),
                          ));
                        })));
          }

          return Text('Hello');
        });
  }
}
