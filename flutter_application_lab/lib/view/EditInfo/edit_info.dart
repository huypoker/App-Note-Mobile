import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



// ignore: must_be_immutable
class EditInfo extends StatefulWidget {

  DocumentSnapshot docToEdit;
  EditInfo({Key? key, required this.docToEdit}) : super(key: key);
  @override
  _EditInfoState createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  TextEditingController _noteEditController = TextEditingController();

  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('contacts');

  @override
  void initState(){
    _noteEditController = TextEditingController(text: widget.docToEdit['Note']);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    return Scaffold(
     appBar : AppBar(
          title: Text('Edit Note',
            style: GoogleFonts.montserrat()
            ),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: [
              // ignore: deprecated_member_use
              FlatButton(onPressed: (){
                if (_formkey.currentState!.validate()){
                  widget.docToEdit.reference.update({
                      'Note' : _noteEditController.text,      
                  }).whenComplete(() => Navigator.pop(context));
                }
              } , child: const Text('Save')
            )
          ],
     ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child:  Column(
              children: <Widget> [
                  Container(
                    margin:const EdgeInsets.all(5),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black,width:1),
                          color: Colors.white
                        ),
                      child: TextFormField(   
                        controller: _noteEditController,   
                        decoration: InputDecoration(
                          labelText: 'Note ',
                          border: InputBorder.none,
                          hintText: "Enter some text",
                          hintStyle: GoogleFonts.montserrat(color: Colors.black)
                          ),
                        ),    
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    ),
  );
}