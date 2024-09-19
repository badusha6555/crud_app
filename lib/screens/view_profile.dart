import 'dart:io';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewProfile extends StatelessWidget {
  String name;
  String age;
  String cls;
  String address;

  dynamic imagePath;
  ViewProfile({
    super.key,
    required this.name,
    required this.age,
    required this.cls,
    required this.address,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: FileImage(File(imagePath)),
            ),
            const SizedBox(height: 20),
            Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: const SizedBox(
                            height: 6,
                          ),
                        ),
                        Title(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          child: Text(
                            'Name:  $name',
                            style: TextStyle(
                                fontSize: 20,
                                color: const Color.fromARGB(255, 255, 56, 56)),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Title(
                          color: Colors.black,
                          child: Text(
                            'Age:  $age ',
                            style: TextStyle(
                                fontSize: 20,
                                color: const Color.fromARGB(255, 255, 0, 0)),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Title(
                          color: Colors.black,
                          child: Text(
                            'Class: $cls ',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 0, 0)),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Title(
                          color: Colors.black,
                          child: Text(
                            'Address: $address ',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 0, 0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
