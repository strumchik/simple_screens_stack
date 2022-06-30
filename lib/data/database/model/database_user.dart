class DatabaseUser {
  final int id;
  final String name;
  final String surname;
  final String email;
  final int gender;
  final String birthdate;

  DatabaseUser(this.id, this.name, this.surname, this.email, this.gender, this.birthdate);

  DatabaseUser.fromDB(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        surname = map['surname'],
        email = map['email'],
        gender = map['gender'],
        birthdate = map['birthdate'];

}
