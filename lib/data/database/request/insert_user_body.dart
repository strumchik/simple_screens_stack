class InsertUserBody {
  final String name;
  final String surname;
  final String email;
  final int gender;
  final String birthdate;

  InsertUserBody({
    required this.name,
    required this.surname,
    required this.email,
    required this.gender,
    required this.birthdate,
  });

  Map<String, dynamic> toDB() {
    return {
      'name': name,
      'surname': surname,
      'email': email,
      'gender': gender,
      'birthdate': birthdate,
    };
  }
}
