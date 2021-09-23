import 'package:date_range_form_field/date_range_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



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
  DateTimeRange?  _myDateRange;

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _priceEditingController = TextEditingController();
  final TextEditingController _noteEditController = TextEditingController();

  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('contacts');

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    return Scaffold(
     appBar : AppBar(
          title: Text('Logbook',
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
                        labelText: 'Activity Name ',
                        border: InputBorder.none,
                        hintText: "Enter activity name",
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
                          labelText: 'Chooose one option'
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
                          labelText: 'Chooose one option'
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
                          labelText: 'Chooose one option'
                        ),
                      ),
                  ),
                ),
                DateRangeField(
                    enabled: true,
                    initialValue: DateTimeRange(
                        start: DateTime.now(),
                        end: DateTime.now().add(const Duration(days: 5))),
                    decoration: const InputDecoration(
                      labelText: 'Date Range',
                      prefixIcon: Icon(Icons.date_range),
                      hintText: 'Please select a start and end date',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.start.isBefore(DateTime.now())) {
                        return 'Please enter a later start date';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _myDateRange = value!;
                      });
                    }),
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
                          content:  const Text(''),
                          actions: <Widget>[
                             Column( ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton( 
                              onPressed: ()  => {  
                                collectionReference.add({
                                'Name of the reporter': _nameEditingController.text,
                                'Monthly rent price': _priceEditingController.text,
                                'Funiture types': _dropdownValue3,
                                'Type of Property': _dropdownValue2,
                                'OptionOfBedrooms': _dropdownValue,
                                'DateRange' : _myDateRange.toString(),
                                'Note' : _noteEditController.text,            
                                })
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
