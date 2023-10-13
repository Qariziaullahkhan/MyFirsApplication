import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myfirst_application/auth/util.dart';

import 'firestore_get_data.dart';
//import 'package:flutter_application_10/businessdetailed.dart';
// import 'package:flutter_application_10/listview.dart';

class Manageraccount extends StatefulWidget {
  const Manageraccount({super.key});

  State<Manageraccount> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Manageraccount> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  // TextEditingController Phonecontroller = TextEditingController();
  bool _isvisiblity = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC6C6C6),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              //  color: Colors.amber,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(220),
                    bottomLeft: Radius.circular(140)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 30),
                    child: Text(
                      "Create your business",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 33,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "manager account",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 33,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    controller: namecontroller,
                    decoration: InputDecoration(
                      hintText: "Name",

                      //labelText: "Email",
                      prefixIcon: Icon(Icons.person),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      hintText: "Email",

                      //labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    controller: passwordcontroller,
                    obscureText: _isvisiblity,
                    decoration: InputDecoration(
                      hintText: "Password",
                      //labelText: "Email",
                      prefixIcon: Icon(Icons.lock),
                      suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              _isvisiblity = !_isvisiblity;
                            });
                          },
                          icon: _isvisiblity
                              ? Icon(
                                  Icons.visibility,
                                  color: Colors.black,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: Colors.black,
                                )),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    obscureText: _isvisiblity,
                    decoration: InputDecoration(
                      hintText: " Confirm Password",
                      //labelText: "Email",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isvisiblity = !_isvisiblity;
                          });
                        },
                        icon: _isvisiblity
                            ? Icon(Icons.visibility, color: Colors.black)
                            : Icon(Icons.visibility_off, color: Colors.black),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  minimumSize: Size(208, 54),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () {
                  // var name = namecontroller.text.trim();
                  // var email = emailcontroller.text.trim();
                  // var password = passwordcontroller.text.trim();
                  // var Phone = Phonecontroller.text.trim();

                  FirebaseAuth auth = FirebaseAuth.instance;
                  FirebaseFirestore store = FirebaseFirestore.instance;

                  auth
                      .signInWithEmailAndPassword(
                    email: emailcontroller.text.trim(),
                    password: passwordcontroller.text.trim(),
                  )
                      .then((value) async {
                    await store.collection("user").add({
                      "name": namecontroller.text.trim(),
                      "email": emailcontroller.text.trim(),
                      "password": passwordcontroller.text.trim(),
                    });
                    Utils.toastmessage("Succesful", Colors.red);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => Getdatefromfirestore()),
                    );
                    // Fluttertoast.showToast(
                    //     msg: "UNSuccesful",
                    //     toastLength: Toast.LENGTH_SHORT,
                    //     gravity: ToastGravity.CENTER,
                    //     timeInSecForIosWeb: 1,
                    //     backgroundColor: Colors.red,
                    //     textColor: Colors.white,
                    //     fontSize: 16.0);
                    // print("this is true");
                  }).onError((error, stackTrace) {
                    Utils.toastmessage("$error", Colors.green);
                    print("this is not true");
                  });
                },
                child: Text(
                  "Next",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have account?",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: ((context) => BusinessDetailed()),
                      //   ),
                      // );
                    },
                    child: Text(
                      "Log in ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
