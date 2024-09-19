import 'dart:io';

import 'package:crud_app/databases/functions.dart';
import 'package:crud_app/model/student.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class EditStudent extends StatefulWidget {
  String name;
  String age;
  String cls;
  String address;
  int index;
  dynamic imagePath;

  EditStudent(
      {super.key,
      required this.name,
      required this.age,
      required this.cls,
      required this.address,
      required this.index,
      required this.imagePath});

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _clsController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  File? _slctImg;

  @override
  Widget build(BuildContext context) {
    _nameController = TextEditingController(text: widget.name);
    _ageController = TextEditingController(text: widget.age);
    _clsController = TextEditingController(text: widget.cls);
    _addressController = TextEditingController(text: widget.address);
    _slctImg = widget.imagePath != '' ? File(widget.imagePath) : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: _slctImg != null
                    ? FileImage(_slctImg!)
                    : const AssetImage('assets/student.jpg') as ImageProvider,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                  onPressed: () {
                    _pickImageGllry();
                  },
                  label: const Text('Gallery'),
                  icon: const Icon(Icons.image)),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  contentPadding: EdgeInsets.all(10),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  contentPadding: EdgeInsets.all(10),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _clsController,
                decoration: const InputDecoration(
                  labelText: 'Class',
                  contentPadding: EdgeInsets.all(10),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  contentPadding: EdgeInsets.all(10),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  updateAll();
                  Navigator.pop(context);
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateAll() async {
    final namee = _nameController.text;
    final agee = _ageController.text;
    final classe = _clsController.text;
    final addresse = _addressController.text;
    final Image1 = _slctImg?.path ?? "";

    if (namee.isEmpty || agee.isEmpty || classe.isEmpty || addresse.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all fields')));
    } else {
      final update = Student(
          name: namee,
          age: agee,
          cls: classe,
          address: addresse,
          imagePath: Image1);
      editing(widget.index, update);
    }
  }

  Future _pickImageGllry() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _slctImg = File(pickedFile.path);
      });
    }
  }
}
