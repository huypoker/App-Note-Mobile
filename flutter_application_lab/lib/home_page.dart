import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_lab/add_info.dart';
import 'package:flutter_application_lab/search_info.dart';


import 'edit_info.dart';

// ignore: use_key_in_widget_constructors
class Homepage extends StatefulWidget {

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  

  final ref = FirebaseFirestore.instance.collection('contacts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed:(){
               Navigator.push(context,MaterialPageRoute(builder: (_) =>  const SearchInfo() ));
          })
        ],
      ),
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.add),
        onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddInfomation()));
        },),
      body: Container(
        child: Column(
          children: <Widget> [
            Expanded(
              child: StreamBuilder(
                stream: ref.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: snapshot.hasData?snapshot.data!.docs.length:0,
                    itemBuilder: (_,index){
                     return GestureDetector(
                       onTap:(){
                         Navigator.push(context, MaterialPageRoute(builder:(_) => EditInfo(docToEdit: snapshot.data!.docs[index],)));
                       },
                       child: Container(
                         margin: const EdgeInsets.all(10),
                         height: 150,
                         color: Colors.grey[200],
                         child: Column(
                           children: [
                             Row(
                               children: <Widget> [
                                  Text(
                                    "Type of Property:  ", style: TextStyle(color: Colors.blueAccent.shade700, fontSize: 13)
                                  ),
                                  Text(snapshot.data!.docs[index]['Type of Property']),
                               ],
                             ),
                             Row(
                               children: <Widget> [
                                  Text(
                                    "Name:  ", style: TextStyle(color: Colors.blueAccent.shade700, fontSize: 13)
                                  ),
                                  Text(snapshot.data!.docs[index]['Name of the reporter']),
                               ],
                             ),
                             Row(
                               children: <Widget> [
                                  Text(
                                    "Price: ", style: TextStyle(color: Colors.blueAccent.shade700, fontSize: 13)
                                  ),
                                  Text(snapshot.data!.docs[index]['Monthly rent price']),
                                  const Text(
                                    "USD/month", style: TextStyle(color: Colors.redAccent, fontSize: 10)
                                  ),
                               ],
                             ),
                             Row(
                               children: <Widget> [
                                  Text(
                                    "Funiture types:", style: TextStyle(color: Colors.blueAccent.shade700, fontSize: 13)
                                  ),
                                  Text(snapshot.data!.docs[index]['Funiture types']),
                               ],
                             ),
                             Row(
                               children: <Widget> [
                                  Text(
                                    "Bedrooms: ", style: TextStyle(color: Colors.blueAccent.shade700, fontSize: 13)
                                  ),
                                  Text(snapshot.data!.docs[index]['OptionOfBedrooms']),
                               ],
                             ),
                             Row(
                               children: <Widget> [
                                  Text(
                                    "Note: ", style: TextStyle(color: Colors.blueAccent.shade700, fontSize: 13)
                                  ),
                                  Text(snapshot.data!.docs[index]['Note']),
                               ],
                             ),
                           ],
                         )
                       ),
                     );
                   });
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}