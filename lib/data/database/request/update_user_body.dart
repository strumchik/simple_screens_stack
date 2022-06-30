class UpdateUserBody {
  final int id;
  final String name;
  final String surname;
  final String email;
  final int gender;
  final String birthdate;

  UpdateUserBody({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.gender,
    required this.birthdate,
  });

  Map<String, dynamic> toDB() {
    return {
      // 'id': id,
      'name': name,
      'surname': surname,
      'email': email,
      'gender': gender,
      'birthdate': birthdate,
    };
  }
}
