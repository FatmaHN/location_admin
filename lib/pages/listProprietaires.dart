// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_final_fields, library_private_types_in_public_api, camel_case_types, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, prefer_const_constructors, avoid_print, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final proprietairekey =GlobalKey<FormState>();
class listProprietaires extends StatefulWidget {
  @override
  _listProprietairesState createState() => _listProprietairesState();
}

class _listProprietairesState extends State<listProprietaires> {
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
        title:const Text('List Proprietaire'),
        actions:const [
         
        ],
      ),
      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Container(
              height: 53,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Recherche par nom proprietaire ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(34)
                  ),
                  prefixIcon:const Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Proprietaire")
                  .where("nom", isGreaterThanOrEqualTo: _searchText)
                  .where("nom", isLessThanOrEqualTo: _searchText + '\uf8ff')
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
                            left: 20, right: 20, top: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 213, 217, 228),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow:const [
                              BoxShadow(
                                color:Color.fromARGB(95, 96, 96, 96),
                                blurRadius: 5 ,
                                offset: Offset(3, 3)
                              )
                            ]
                          ),
                          child: ListTile(
                          leading: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6)
                            ),
                            child: Icon(Icons.person)),
                          title: Text(doc['nom']),
                          subtitle: Text(doc['email']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                             
                                IconButton(
                                                        onPressed: ()async {
                                                        var uidPublication=snapshot.data!.docs[index].id; 
                                                        showDialog(context: context, 
                                                        builder: (context){
                                                        return AlertDialog(
                                                        content: Container(
                                                          height: 200,
                                                          child: StreamBuilder(
                                                            stream: FirebaseFirestore.instance
                                                            .collection('Proprietaire')
                                                            .doc(uidPublication)
                                                            .snapshots(),
                                                            builder: (context, AsyncSnapshot snapshot) {
                                                            if(snapshot.hasData) { 
                                                              return  Container(
                                                                child: Form(
                                                                 key: proprietairekey,
                                                                  child:Column(
                                                                   children: [
                                                                    Column(
                                                                    children: [
                                                                     SizedBox(height: 30,),
                                                                     Text("Voulez-vous supprimer ce publication",
                                                                      style: TextStyle(
                                                                       fontSize: 22,
                                                                       color: Colors.black,
                                                                       fontWeight: FontWeight.w500
                                                                        ),),
                                                                         SizedBox(height: 40),
                                                                          Row(
                                                                          children: [
                                                                          SizedBox(width: 10,),
                                                                         Container(
                                                                           height: 50,
                                                                           width: 100,
                                                                           decoration: BoxDecoration(
                                                                             color: Colors.red,
                                                                             borderRadius: BorderRadius.circular(13)
                                                                                              ),
                                                                                              child: CupertinoButton(
                                                                             child: Text("Supprimer",
                                                                             style: TextStyle(
                                                                               color: Colors.white
                                                                             ),),
                                                                             onPressed: ()async{
                                                                               snapshot.data!.reference.delete().whenComplete(() => Navigator.pop(context));
                                                                             },
                                                                                              ),
                                                                                             ),
                                                                                             SizedBox(width: 20,),
                                                                                              Container(
                                                                                              height: 50,
                                                                                              width: 100,
                                                                                              decoration: BoxDecoration(
                                                                                                color: Color.fromARGB(255, 193, 193, 193),
                                                                                                borderRadius: BorderRadius.circular(13)
                                                                                              ),
                                                                                              child: CupertinoButton(
                                                                                                child: Text("Annuler",
                                                                                                style: TextStyle(
                                                                                                  color: Colors.white
                                                                                                ),),
                                                                                                onPressed: ()async{
                                                                                                  Navigator.pop(context);
                                                                                                },
                                                                                              ),
                                                                                             ),
                                                                                           ],
                                                                                         )                                      
                                                                   
                                                                                     
                                                                                                           
                                                                                                          
                                                                                                            ]
                                                                                                          ),
                                                                                                          ]
                                                                                                        )
                                                                                                       ),
                                                              );
                                                            }else{
                                                              return Container();
                                                            }
                                                            }
                                                          ),
                                                        ),
                                                        );
                                                        }) ;
                                                        },
                                                       icon:Icon( Icons.delete,
                                                        color: Colors.red,
                                                      )),
                            ],
                          ),
                                                ),
                        )
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

