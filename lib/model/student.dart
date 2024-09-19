import 'package:hive_flutter/hive_flutter.dart';

part 'student.g.dart';

@HiveType(typeId: 0)
class Student {
  @HiveField(0)
  String name;

  @HiveField(1)
  String age;

  @HiveField(2)
  String cls;

  @HiveField(3)
  String address;

  @HiveField(4)
  String? imagePath;

  Student({
    required this.name,
    required this.age,
    required this.cls,
    required this.address,
    required this.imagePath,
  });
}
