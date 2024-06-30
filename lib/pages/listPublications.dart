// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, file_names, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, prefer_const_constructors, avoid_print, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final publicationkey = GlobalKey<FormState>();

class ListPublication extends StatefulWidget {
  @override
  _ListPublicationState createState() => _ListPublicationState();
}

class _ListPublicationState extends State<ListPublication> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Publication'),
        actions: const [],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Container(
              height: 53,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Recherche par nom proprietaire ',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(34)),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Publication")
                  .where("nomProprietaire", isGreaterThanOrEqualTo: _searchText)
                  .where("nomProprietaire",
                      isLessThanOrEqualTo: _searchText + '\uf8ff')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  var docs = snapshot.data!.docs;
                  print("Number of documents fetched: ${docs.length}");

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      var doc = docs[index];
                      print("Fetched doc: ${doc.data()}");
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 13, right: 13),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(13),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(95, 96, 96, 96),
                                  blurRadius: 8,
                                )
                              ]),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color:
                                                Color.fromARGB(83, 0, 0, 0))),
                                    child: Icon(Icons.person)),
                                title: Text(
                                  doc['nomProprietaire'],
                                  style: TextStyle(
                                      color: Color(0xFF3C2DA5),
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: IconButton(
                                    onPressed: () async {
                                      var uidPublication =
                                          snapshot.data!.docs[index].id;
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Container(
                                                height: 200,
                                                child: StreamBuilder(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'Publication')
                                                        .doc(uidPublication)
                                                        .snapshots(),
                                                    builder: (context,
                                                        AsyncSnapshot
                                                            snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Container(
                                                          child: Form(
                                                              key:
                                                                  publicationkey,
                                                              child: Column(
                                                                  children: [
                                                                    Column(
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                30,
                                                                          ),
                                                                          Text(
                                                                            "Voulez-vous supprimer ce publication",
                                                                            style: TextStyle(
                                                                                fontSize: 22,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w500),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 40),
                                                                          Row(
                                                                            children: [
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Container(
                                                                                height: 50,
                                                                                width: 100,
                                                                                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(13)),
                                                                                child: CupertinoButton(
                                                                                  child: Text(
                                                                                    "Supprimer",
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                  onPressed: () async {
                                                                                    snapshot.data!.reference.delete().whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context) => ListPublication())));
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 20,
                                                                              ),
                                                                              Container(
                                                                                height: 50,
                                                                                width: 100,
                                                                                decoration: BoxDecoration(color: Color.fromARGB(255, 193, 193, 193), borderRadius: BorderRadius.circular(13)),
                                                                                child: CupertinoButton(
                                                                                  child: Text(
                                                                                    "Annuler",
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                  onPressed: () async {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ]),
                                                                  ])),
                                                        );
                                                      } else {
                                                        return Container();
                                                      }
                                                    }),
                                              ),
                                            );
                                          });
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      doc['adresse'],
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 121, 121, 121),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  doc['description'],
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                              Image.network(
                                doc['imagUrl'],
                                width: double.infinity,
                                height: 240,
                                fit: BoxFit.cover,
                              ),
                              ExpansionTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(),
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.favorite,
                                        color: Color(0xFF3C2DA5),
                                      ),
                                    ],
                                  ),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(right: 220),
                                  child: Icon(
                                    Icons.comment,
                                    color: Color(0xFF3C2DA5),
                                  ),
                                ),
                                children: List.generate(
                                    3,
                                    (index) => ListTile(
                                        title: Text('Subtile $index'))),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("No data available"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
