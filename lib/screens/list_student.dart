import 'dart:io';

import 'package:crud_app/databases/functions.dart';
import 'package:crud_app/model/student.dart';
import 'package:crud_app/screens/add_student.dart';
import 'package:crud_app/screens/edit_student.dart';
import 'package:crud_app/screens/view_profile.dart';

import 'package:crud_app/screens1/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListStudent extends StatefulWidget {
  const ListStudent({super.key});

  @override
  State<ListStudent> createState() => _ListStudentState();
}

class _ListStudentState extends State<ListStudent> {
  String search = '';
  List<Student> searchedList = [];
  void searchListUpdate() {
    getAllStudents();
    searchedList = studentListNotifier.value
        .where((stdModel) =>
            stdModel.name.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    searchListUpdate();

    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 0, 222, 126),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 86, 33, 243),
        child: const Icon(Icons.person_add_alt),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddStudent()));
        },
      ),
      appBar: AppBar(
        title: const Text('Student List'),
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                _logout();
              }),
        ],
      ),
      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  search = value;
                  searchListUpdate();
                });
              },
              decoration: const InputDecoration(
                fillColor: Colors.white,
                labelText: 'Search',
                labelStyle: TextStyle(color: Colors.white),
                focusColor: Colors.white,
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: studentListNotifier,
              builder:
                  // ignore: avoid_types_as_parameter_names
                  (BuildContext, List<Student> studentList, Widget? child) {
                return search.isNotEmpty
                    ? searchedList.isEmpty
                        ? const Center(
                            child: Text(
                              'No results found.',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : _buildStudentList(searchedList)
                    : _buildStudentList(studentList);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentList(List<Student> students) {
    return students.isEmpty
        ? const Center(
            child: Text(
              'No students available.',
              style: TextStyle(color: Colors.white),
            ),
          )
        : ListView.separated(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final data = students[index];
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ViewProfile(
                        name: data.name,
                        age: data.age,
                        cls: data.cls,
                        address: data.address,
                        imagePath: data.imagePath,
                      ),
                    ),
                  );
                },
                title: Text(
                  data.name,
                  style: const TextStyle(color: Colors.white),
                ),
                leading: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 25, 25, 81),
                  backgroundImage: data.imagePath != null
                      ? FileImage(File(data.imagePath ?? "N/A"))
                      : const AssetImage("assets/student.jpg") as ImageProvider,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditStudent(
                              index: index,
                              name: data.name,
                              cls: data.cls,
                              address: data.address,
                              age: data.age,
                              imagePath: data.imagePath,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 123, 146, 185),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirm Deletion'),
                              content: const Text(
                                  'Are you sure you want to delete this student?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    deleteStudent(index);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  color: Colors.white,
                ),
              );
            },
          );
  }
}

void _logout() {
  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
