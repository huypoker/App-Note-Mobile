
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_lab/view/Dashboard/dashboard_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'screen_noti.dart';





class AddInfomation extends StatefulWidget {
  const AddInfomation({Key? key}) : super(key: key);
  @override
  _AddInfomationState createState() => _AddInfomationState();
}

class _AddInfomationState extends State<AddInfomation> {
  final items = ['Studio','1', '2', '3', '>3'];
  final itmes2= ['flat', 'house', 'bungalow'];
  final itmes3 = ['Furnished', 'Unfurnished', 'Part Furnised'];

  String? _dropdownValue3;
  String? _dropdownValue2;
  String? _dropdownValue;
  DateTime selectedDate = DateTime.now();

  final TextEditingController _date = TextEditingController();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _priceEditingController = TextEditingController();
  final TextEditingController _noteEditController = TextEditingController();

  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('contacts');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _date.value = TextEditingValue(text: picked.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    return Scaffold(
     appBar : AppBar(
          title: Text('Add Form',
            style: GoogleFonts.montserrat()
            ),
          centerTitle: true,
          backgroundColor: Colors.blue,
     ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child:  Column(
              children: <Widget> [
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black,width:1),
                        color: Colors.white
                      ),
                    child: TextFormField(   
                      controller: _nameEditingController,   
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },  
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: InputBorder.none,
                        hintText: "Enter name of the reporter",
                        hintStyle: GoogleFonts.montserrat(color: Colors.black)
                        ),
                      ),    
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black,width:1),
                        color: Colors.white
                      ),
                    child: TextFormField(   
                      keyboardType: TextInputType.number, 
                      inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: _priceEditingController,   
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter price';
                        }
                        return null;
                      }, 
                      decoration: InputDecoration(
                        labelText: 'Monthly rent price',
                        border: InputBorder.none,
                        hintText: "Enter price with VND/month",
                        hintStyle: GoogleFonts.montserrat(color: Colors.black)
                        ),
                      ),    
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.symmetric(horizontal:12, vertical:4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black,width:1)
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(   
                      value: _dropdownValue2,
                      iconSize:36,
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                      isExpanded: true,
                      items: itmes2.map(buildMenuItem).toList(),
                      onChanged: (newvalue) {
                        setState(() { 
                          _dropdownValue2 = newvalue;
                        });
                        },
                        validator: (value) => value == null
                        ? 'Please fill in your option' : null,
                        decoration: const InputDecoration(
                          labelText: 'Type of Property'
                        ),
                      ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.symmetric(horizontal:12, vertical:4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black,width:1)
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(   
                      value: _dropdownValue3,
                      iconSize:36,
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                      isExpanded: true,
                      items: itmes3.map(buildMenuItem).toList(),
                      onChanged: (newvalue) {
                        setState(() { 
                          _dropdownValue3 = newvalue;
                        });
                        },
                        validator: (value) => value == null
                        ? 'Please fill in your option' : null,
                        decoration: const InputDecoration(
                          labelText: 'Funiture types'
                        ),
                      ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.symmetric(horizontal:12, vertical:4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black,width:1)
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(   
                      value: _dropdownValue,
                      iconSize:36,
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                      isExpanded: true,
                      items: items.map(buildMenuItem).toList(),
                      onChanged: (newvalue) {
                        setState(() { 
                          _dropdownValue = newvalue;
                        });
                        },
                        validator: (value) => value == null
                        ? 'Please fill in your option' : null,
                        decoration: const InputDecoration(
                          labelText: 'Option of Bedrooms'
                        ),
                      ),
                  ),
                ),
                const SizedBox(height: 3),
                GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _date,
                            validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please choose date picker';
                          }
                          return null;
                        },  
                            keyboardType: TextInputType.datetime,
                            decoration: const InputDecoration(
                              hintText: 'Date picker',
                              prefixIcon: Icon(
                                Icons.dialpad,
                              ),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 3),
                Container(
                  margin: const EdgeInsets.all(5),
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
                TextButton(
                  onPressed: () async{
                    if (_formkey.currentState!.validate()){
                      await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                          title: const Text('AlertDialog Title'),
                          content: Material( 
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget> [
                                Text(_nameEditingController.text),
                                Text(_priceEditingController.text),
                                Text(_dropdownValue3!),
                                Text(_dropdownValue2!),
                                Text(_dropdownValue!),
                                Text(_date.text),
                                Text(_noteEditController.text),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton( 
                              onPressed: ()  => {  
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const ScreenNoti())),
                                collectionReference.add({
                                'Name of the reporter': _nameEditingController.text,
                                'Monthly rent price': _priceEditingController.text,
                                'Funiture types': _dropdownValue3,
                                'Type of Property': _dropdownValue2,
                                'OptionOfBedrooms': _dropdownValue,
                                'DateRange' : _date.text,
                                'Note' : _noteEditController.text,            
                                }),
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                    child: const Text('Submit'),
                )
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
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
}
