
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/data_controller.dart';
import '../EditInfo/edit_info.dart';

class SearchInfo extends StatefulWidget {
  const SearchInfo({ Key? key }) : super(key: key);
  

  @override
  _SearchInfoState createState() => _SearchInfoState();
}


class _SearchInfoState extends State<SearchInfo> {
  final TextEditingController searchController = TextEditingController();
  late QuerySnapshot snapshotData; 
  bool isExcectual = false;
  @override
  Widget build(BuildContext context) {
    Widget searchData(){
      return ListView.builder(
        itemCount: snapshotData.docs.length, 
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Column(
              children: <Widget> [
                ListTile(
                  title: Text(snapshotData.docs[index]['Type of Property'], style: const TextStyle(color: Colors.red, fontSize: 13)),
                  subtitle: Text(snapshotData.docs[index]['Name of the reporter'], style: const TextStyle(color: Colors.red, fontSize: 13)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder:(_) => EditInfo(docToEdit: snapshotData.docs[index],)));
                  },
                ),
              ],
            ),
          );
        } 
      );
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.clear),
        onPressed: (){
          setState((){
            isExcectual = false;
          });
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          GetBuilder<DataController>(
          init: DataController(),
          builder:(val){
                return IconButton(
                  icon: const Icon(Icons.search), 
                  onPressed:(){
                    val.queryData(searchController.text).then((value){
                      snapshotData = value;
                      setState((){
                      isExcectual = true;
                    });
                  });
              });
            },
          )
        ],
        title: TextField(
          style: const TextStyle(color:Colors.white),
          decoration: const InputDecoration(
            hintText: 'Search Type of Property',
            hintStyle: TextStyle(color: Colors.white),
          ),
          controller: searchController,
        ),
      ),
      body: isExcectual 
        ? searchData() :
        const Center(
          child: Text('', style: TextStyle(
            color: Colors.blue, fontSize: 30.0
          )),
        )
    );
  }
}

