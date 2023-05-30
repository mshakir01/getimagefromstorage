import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:getdatafirebasestorage/storage_services.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(
        title: Text("Storage "),
      ),
      body: Column(children: [
        Center(
          child: ElevatedButton(
            onPressed: () async {
              final results = await FilePicker.platform.pickFiles(
                allowMultiple: true,
                type: FileType.custom,
                allowedExtensions: ['png', 'jpg'],
              );

              if (results == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("No file Selected"),
                  ),
                );
                return null;
              }
              final path = results.files.single.path!;
              final fileName = results.files.single.name;

              storage.uploadFile(path, fileName).then((value) => print("Done"));

              // print(path);
              // print(fileName);
            },
            child: Text("Upload File"),
          ),
        ),
        // FutureBuilder(
        //     future: storage.listFile(),
        //     builder: (BuildContext context,
        //         AsyncSnapshot<firebase_storage.ListResult> snapshot) {
        //       if (snapshot.connectionState == ConnectionState.done &&
        //           snapshot.hasData) {
        //         return Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Container(
        //             height: 200,
        //             width: 100,
        //             child: ListView.builder(
        //                 scrollDirection: Axis.vertical,
        //                 shrinkWrap: true,
        //                 itemCount: snapshot.data!.items.length,
        //                 itemBuilder: (BuildContext context, int index) {
        //                   return ElevatedButton(
        //                     onPressed: () {},
        //                     child: Text(snapshot.data!.items[index].name),
        //                   );
        //                 }),
        //           ),
        //         );
        //       }
        //       if (snapshot.connectionState == ConnectionState.waiting ||
        //           !snapshot.hasData) {
        //         return CircularProgressIndicator();
        //       }
        //       return Container();
        //     }),
        FutureBuilder(
            future: storage.downloadURL('IMG_20230530_104539.jpg'),
            builder: (BuildContext context,
                AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Container(
                  width: 300,
                  height: 200,
                  child: Image.network(snapshot.data!,fit: BoxFit.cover,),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return Container();
            }),
      ]),
    );
  }
}
