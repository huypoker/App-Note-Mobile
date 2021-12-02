import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/home_controller.dart';
import '../EditInfo/edit_info.dart';


class HomeView extends GetView<HomeController> {
  final ref = FirebaseFirestore.instance.collection('contacts');

   HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      appBar: AppBar(
         title: Text('Homepage',
            style: GoogleFonts.montserrat()
            ),
          centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget> [
          Expanded(
            child: StreamBuilder(
              stream: ref.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: snapshot.hasData?snapshot.data!.docs.length:0,
                  itemBuilder: (_,index){
                    final AlertDialog dialog = AlertDialog(
                    title: const Text('Are you sure you want to delete it?'),
                    actions: [
                      // ignore: deprecated_member_use
                      FlatButton(
                        textColor: const Color(0xFF6200EE),
                        onPressed: () => Navigator.pop(context),
                        child: const Text('CANCEL'),
                      ),
                      // ignore: deprecated_member_use
                      FlatButton(
                        textColor: const Color(0xFF6200EE),
                        onPressed: () async {    
                            Navigator.of(context).pushNamedAndRemoveUntil(
                          '/DashboardPage',
                          (Route<dynamic> route) => false);
                            await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                myTransaction.delete(snapshot.data!.docs[index].reference);
                            }); 
                          },
                        child: const Text('ACCEPT'),
                      ),
                    ],
                  );
                   return GestureDetector(
                     onTap:(){
                       Navigator.push(context, MaterialPageRoute(builder:(_) => EditInfo(docToEdit: snapshot.data!.docs[index],)));
                     }, 
                     child: Container(
                       margin: const EdgeInsets.all(10),
                       height: 150,
                       color: Colors.grey[200],
                       child: Column(
                         children: <Widget> [
                           // ignore: deprecated_member_use
                           FlatButton(
                              textColor: const Color(0xFF6200EE),
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                showDialog<void>(context: context, builder: (context) => dialog);
                              },
                              child: const Icon(Icons.delete), 
                            ),
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
                                  "Date time: ", style: TextStyle(color: Colors.blueAccent.shade700, fontSize: 13)
                                ),
                             ],
                           ),
                           Row(
                             children: <Widget> [
                                Text(snapshot.data!.docs[index]['DateRange'], style: const TextStyle(color: Colors.black, fontSize: 13))
                             ]
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
 
    );
  }
}