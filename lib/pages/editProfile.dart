// ignore_for_file: camel_case_types, file_names, avoid_unnecessary_containers, sized_box_for_whitespace, unused_element, use_build_context_synchronously, must_be_immutable, non_constant_identifier_names

//cette page de modification profile admin
import 'package:admin_location/services/services_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ServAdmin _authServiceAdminServAdmin = ServAdmin();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
User admin = _firebaseAuth.currentUser!;
final editeprofilekey = GlobalKey<FormState>();

TextEditingController ModifnomC = TextEditingController();
TextEditingController ModifadresseC = TextEditingController();
TextEditingController ModifphoneC = TextEditingController();

class editeProfileScreen extends StatefulWidget {
  editeProfileScreen({super.key});
  User admin = _firebaseAuth.currentUser!;
  @override
  State<editeProfileScreen> createState() => _editeProfileScreenState();
}

class _editeProfileScreenState extends State<editeProfileScreen> {
  bool isvisible = true;
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  child: Stack(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 140,
                            ),
                            const CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 231, 231, 231),
                              radius: 50,
                              child: Icon(
                                Icons.person,
                                size: 47,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 70,
                            ),
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("Admin")
                                    .doc(widget.admin.uid)
                                    .snapshots(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    ModifnomC.text = snapshot.data!['nom'];
                                  }
                                  return Form(
                                    key: editeprofilekey,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 29),
                                          child: Container(
                                            height: 64,
                                            child: TextFormField(
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              controller: ModifnomC,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Name cannot be empty ';
                                                }
                                                if (!RegExp(r'^[a-z- A-Z]+$')
                                                    .hasMatch(value)) {
                                                  return 'Please enter valid name';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelStyle: const TextStyle(
                                                      color: Color(0xFF3C2DA5)),
                                                  hintStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 126, 125, 125)),
                                                  hintText: "user name",
                                                  labelText: "Name",
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Color(
                                                                0xFFD7D7D7),
                                                            width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            13),
                                                  ),
                                                  prefixIcon: const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 9),
                                                    child: SizedBox(
                                                      width: 50,
                                                      child: Icon(
                                                        Icons.person,
                                                        size: 26,
                                                        color:
                                                            Color(0xFF3C2DA5),
                                                      ),
                                                    ),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Color(
                                                                  0xFFD7D7D7),
                                                              width: 2)),
                                                  errorBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Color(
                                                                  0xFFFF2600),
                                                              width: 2)),
                                                  border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Color(
                                                                0xFFD7D7D7),
                                                            width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            13),
                                                  )),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 34,
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 26,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6),
                                              child: Container(
                                                height: 54,
                                                width: 164,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(13),
                                                  color: const Color.fromARGB(
                                                      255, 231, 231, 231),
                                                ),
                                                child: CupertinoButton(
                                                  child: const Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18),
                                                  ),
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: Container(
                                                height: 54,
                                                width: 164,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(13),
                                                  color:
                                                      const Color(0xFF3C2DA5),
                                                ),
                                                child: CupertinoButton(
                                                    child: const Text(
                                                      "Modifier",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    onPressed: () async {
                                                      if (editeprofilekey
                                                          .currentState!
                                                          .validate()) {
                                                        snapshot.data!.reference
                                                            .update({
                                                          "nom": ModifnomC.text,
                                                        }).whenComplete(() =>
                                                                Navigator.pop(
                                                                    context));
                                                      }
                                                    }),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
