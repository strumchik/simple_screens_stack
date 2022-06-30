import 'package:simple_screens_stack/domain/model/user.dart';
import 'package:simple_screens_stack/data/database/model/database_user.dart';

class UserMapper {
  static User fromDB(DatabaseUser user) {
    return User(
        id: user.id.toInt(),
        name: user.name.toString(),
        surname: user.surname.toString(),
        email: user.email.toString(),
        gender: user.gender.toInt(),
        birthdate: DateTime.parse(user.birthdate));
  }

  static DatabaseUser toDB(User user) {
    return DatabaseUser(
         0,
         user.name.toString(),
         user.surname.toString(),
         user.email.toString(),
         user.gender.toInt(),
         user.birthdate.toString()
    );
  }
}
