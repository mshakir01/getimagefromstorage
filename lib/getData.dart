import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetDataScreen extends StatefulWidget {
  const GetDataScreen({Key? key}) : super(key: key);

  @override
  State<GetDataScreen> createState() => _GetDataScreenState();
}

getData() async {
  String imageUrl = '';

  final data = await FirebaseFirestore.instance
      .collection('data')
      .doc()
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      var data = documentSnapshot.data();

      //imageUrl = data!['image'];
// Perform further operations with the retrieved image URL
    }
  });
  print("testing ${getData}");
}

// getDatafromFirebase() async {
//   final imageRef =await FirebaseFirestore.instance.collection('data').doc();
//   imageRef.get().then((value) {
//    final image=value.data();
//    print("testing image${image}");
//   });
//   print("testing ${imageRef}");
//
//
// }

class _GetDataScreenState extends State<GetDataScreen> {

  @override
  Widget build(BuildContext context) {
    print("testing ${getData()}");
    return Scaffold(
      body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return ListView.builder(itemBuilder: (context, index) {
                print("testing ${snapshot.data![index]}");
                // return Image.network(imageUrl);
              });
            }

            return Container();
          }),
    );
  }
}
