import 'package:simple_screens_stack/data/mapper/user_mapper.dart';
import 'package:simple_screens_stack/domain/model/user.dart';
import 'package:simple_screens_stack/domain/repository/user_repository.dart';
import '../../data/database/service/user_service.dart';

class UserDataRepository extends UserRepository {
  final UserService _userService = UserService();

  UserDataRepository();

  @override
  Future<User> createUser  (
      {required String name,
      required String surname,
      required String email,
      required int gender,
      required DateTime birthdate}) async {
    final user = User(
        id: 0,
        name: name,
        surname: surname,
        email: email,
        gender: gender,
        birthdate: birthdate);
    return  _userService.insertUser(UserMapper.toDB(user));
    // DatabaseUser databaseUser =
    //     DatabaseUser(0, name, surname, email, gender, birthdate.toString());
    // return _userService.insertUser(databaseUser);
  }

  @override
  Future<User> getUser({required int id})  {
    return _userService.getUser(id: id);
  }

  @override
  Future<List<User>> getUsers()  {
    final users = _userService.getUsers();
    return users;
  }

}
