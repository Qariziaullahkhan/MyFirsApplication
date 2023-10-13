import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Getdatefromfirestore extends StatefulWidget {
  const Getdatefromfirestore({super.key});

  @override
  State<Getdatefromfirestore> createState() => _GetdatefromfirestoreState();
}

class _GetdatefromfirestoreState extends State<Getdatefromfirestore> {
  var firestore = FirebaseFirestore.instance.collection("user").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text("Firestore Data"),
      ),
      body: StreamBuilder(
          stream: firestore,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs;
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(data[index]["name"].toString()),
                        subtitle: Text(data[index]["email"].toString()),
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
