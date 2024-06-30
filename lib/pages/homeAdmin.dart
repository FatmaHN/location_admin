// ignore_for_file: file_names, unused_element, camel_case_types, must_be_immutable, avoid_unnecessary_containers, non_constant_identifier_names


import 'package:admin_location/pages/listEtudiants.dart';
import 'package:admin_location/pages/listProprietaires.dart';
import 'package:admin_location/pages/listPublications.dart';

import 'package:admin_location/pages/listReclamations.dart';
import 'package:admin_location/services/services_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

ServAdmin _authServiceAdminServAdmin = ServAdmin();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

User user = _firebaseAuth.currentUser!;

class homeAdmin extends StatefulWidget {
  homeAdmin({super.key});
  User user = _firebaseAuth.currentUser!;
  @override
  State<homeAdmin> createState() => _homeAdminState();
}

class _homeAdminState extends State<homeAdmin> {
  Future<int> _getCollectionCount(String collectionName) async {
    QuerySnapshot snapshot = await _firebaseFirestore.collection(collectionName).get();
    return snapshot.docs.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Admin")
            .doc(widget.user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: Row(
                      children: [],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 100,
                    width: 380,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF3C2DA5)),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Welcome back!",
                                style: TextStyle(
                                  color: Color(0xFF3C2DA5),
                                  fontSize: 21,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                snapshot.data!['nom'],
                                style: const TextStyle(
                                  color: Color(0xFF3C2DA5),
                                  fontSize: 21,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 80),
                        Image.asset("assets/admin.png", height: 150),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: FutureBuilder<int>(
                          future: _getCollectionCount('Proprietaire'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error');
                            } else {
                              return InkWell(
                              onTap: () {
                                Navigator.push(context, 
                                MaterialPageRoute(builder: (context)=> listProprietaires()));
                              },
      child: Container(
        height: 130,
        width: 184,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 235, 236, 238),
          border: Border.all(color: const Color.fromARGB(255, 212, 212, 212)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 19, right: 10, top: 20),
                  child: Container(
                    height: 46,
                    width: 46,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(51, 0, 0, 0),
                          blurRadius: 6,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(Icons.group, color: Color(0xFF3C2DA5), size: 24),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    snapshot.data!.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Icon(Icons.trending_up, color: Colors.green, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Totale Proprietaires",
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
                              
                             
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 1),
                        child: FutureBuilder<int>(
                          future: _getCollectionCount('Etudiant'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error');
                            } else {
                              return  InkWell(
                              onTap: () {
                                Navigator.push(context, 
                                MaterialPageRoute(builder: (context)=> ListEtudianr()));
                              },
      child: Container(
        height: 130,
        width: 184,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 235, 236, 238),
          border: Border.all(color: const Color.fromARGB(255, 212, 212, 212)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 19, right: 10, top: 20),
                  child: Container(
                    height: 46,
                    width: 46,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(51, 0, 0, 0),
                          blurRadius: 6,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(Icons.groups, color: Color(0xFF3C2DA5), size: 24),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    snapshot.data!.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Icon(Icons.trending_up, color: Colors.green, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Totale Etudiants",
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
                              
                           
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: FutureBuilder<int>(
                          future: _getCollectionCount('Publication'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error');
                            } else {
                              return  InkWell(
                              onTap: () {
                                Navigator.push(context, 
                                MaterialPageRoute(builder: (context)=> ListPublication()));
                              },
      child: Container(
        height: 130,
        width: 184,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 235, 236, 238),
          border: Border.all(color: const Color.fromARGB(255, 212, 212, 212)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 19, right: 10, top: 20),
                  child: Container(
                    height: 46,
                    width: 46,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(51, 0, 0, 0),
                          blurRadius: 6,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(Icons.article, color: Color(0xFF3C2DA5), size: 24),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    snapshot.data!.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Icon(Icons.trending_up, color: Colors.green, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Totale Publications",
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
                              
                            
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 1),
                        child: FutureBuilder<int>(
                          future: _getCollectionCount('Réclamation'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error');
                            } else {
                              return  InkWell(
                              onTap: () {
                                Navigator.push(context, 
                                MaterialPageRoute(builder: (context)=> ListReclamations()));
                              },
      child: Container(
        height: 130,
        width: 184,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 235, 236, 238),
          border: Border.all(color: const Color.fromARGB(255, 212, 212, 212)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 19, right: 10, top: 20),
                  child: Container(
                    height: 46,
                    width: 46,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(51, 0, 0, 0),
                          blurRadius: 6,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(Icons.report_problem, color: Color(0xFF3C2DA5), size: 24),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    snapshot.data!.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Icon(Icons.trending_down, color: Colors.red, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Totale Réclamations",
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
                              
                           
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildStatCard(String title, int count, IconData icon, Color trendColor) {
    return InkWell(
      
      child: Container(
        height: 130,
        width: 184,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 235, 236, 238),
          border: Border.all(color: const Color.fromARGB(255, 212, 212, 212)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 19, right: 10, top: 20),
                  child: Container(
                    height: 46,
                    width: 46,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(51, 0, 0, 0),
                          blurRadius: 6,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(icon, color: Color(0xFF3C2DA5), size: 24),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    count.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Icon(Icons.trending_up, color: trendColor, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
