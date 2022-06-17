import 'package:intl/intl.dart';

class User {
  final int id;
  final String name;
  final String surname;
  final String email;
  final int gender;
  final DateTime birthdate;

  const User({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.gender,
    required this.birthdate,
  });

  Map<String, dynamic> toMap() {
    String birthdateString = birthdate.toString();
    return {
      'name': name,
      'surname': surname,
      'email': email,
      'gender': gender,
      'birthdate': birthdateString,
    };
  }

  String getGenderName() {
    switch (gender) {
      case 1:
        return "male";
      case 2:
        return "female";
      default:
        return "none";
    }
  }

  String getBirthdateAsText() {
    final DateFormat dateFormat = DateFormat('dd MMMM yyyy');
    final String formatted = dateFormat.format(birthdate);
    return formatted;
  }

  @override
  String toString() {
    String birthdateString = birthdate.toString();
    return 'User{id: $id, name: $name, surname: $surname, '
        'email: $email, gender: $gender, birthdate: $birthdateString}';
  }
}
