import 'dart:developer';
import 'dart:io';

import 'package:crud_app/databases/functions.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/model/student.dart';
import 'package:image_picker/image_picker.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _clsController = TextEditingController();
  final _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _selectImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
        shape: const CircleBorder(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                backgroundImage: _selectImage != null
                    ? FileImage(_selectImage!)
                    : const AssetImage('assets/student.jpg') as ImageProvider,
              ),
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  _pickImageGallery();
                },
                label: const Text('Gallery'),
                icon: const Icon(Icons.image)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        } else {
                          return null;
                        }
                      },
                      controller: _nameController,
                      decoration: const InputDecoration(
                          labelText: 'Name', border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your age';
                        } else {
                          return null;
                        }
                      },
                      controller: _ageController,
                      decoration: const InputDecoration(
                          labelText: 'Age', border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your class';
                        } else {
                          return null;
                        }
                      },
                      controller: _clsController,
                      decoration: const InputDecoration(
                          labelText: 'Class', border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your address';
                        } else {
                          return null;
                        }
                      },
                      controller: _addressController,
                      decoration: const InputDecoration(
                          labelText: 'Address', border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          onAddStudentBtn();
                          Navigator.pop(context);
                        }
                      },
                      child: const Icon(
                        Icons.person_add_alt,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onAddStudentBtn() async {
    final name = _nameController.text;
    final age = _ageController.text;
    final cls = _clsController.text;
    final address = _addressController.text;
    if (name.isEmpty || age.isEmpty || cls.isEmpty || address.isEmpty) {
      return;
    }
    final student = Student(
        name: name,
        age: age,
        cls: cls,
        address: address,
        imagePath: _selectImage?.path ?? "");
    addStudent(student);
    log(student.name);
  }

  Future _pickImageGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    } else {
      setState(() {
        _selectImage = File(pickedFile.path);
      });
    }
  }
}
