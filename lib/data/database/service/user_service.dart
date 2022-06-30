import 'package:simple_screens_stack/data/database/db_driver.dart';
import 'package:simple_screens_stack/data/database/request/insert_user_body.dart';
import 'package:simple_screens_stack/domain/model/user.dart';

import '../../mapper/user_mapper.dart';
import '../model/database_user.dart';
import '../request/get_user_body.dart';
import '../request/update_user_body.dart';

class UserService {
  final _dbDriver = DBDriver();
  final usersTableName = 'users';

  Future<List<User>> getUsers() async {
    final List<Map<String, dynamic>> maps = await _dbDriver.select('users', '');
    return List.generate(maps.length, (i) {
      final result = UserMapper.fromDB(DatabaseUser.fromDB(maps[i]));
      return result;
    });
  }

  Future<User> insertUser(DatabaseUser databaseUser) async {
    final value = InsertUserBody(
        name: databaseUser.name,
        surname: databaseUser.surname,
        email: databaseUser.email,
        gender: databaseUser.gender,
        birthdate: databaseUser.birthdate);
    final userId = await _dbDriver.insert(usersTableName, value.toDB());
    return getUser(id: userId);
  }

  Future<User> getUser({required int id}) async {
    final body = GetUserBody(id: id);
    String whereText = "";
    body.toDB().forEach((key, value) => value!=null ? whereText += "$key = $value, " : null);
    whereText = whereText.substring(0, whereText.lastIndexOf(","));
    final result = await _dbDriver.select(usersTableName, whereText);
    final dbUser = DatabaseUser.fromDB(result[0]);
    return UserMapper.fromDB(dbUser);
  }

  Future<User> updateUser(DatabaseUser databaseUser) async {
    final body = UpdateUserBody(
        id: databaseUser.id,
        name: databaseUser.name,
        surname: databaseUser.surname,
        birthdate: databaseUser.birthdate,
        email: databaseUser.email,
        gender: databaseUser.gender,
    );
    _dbDriver.update(usersTableName, body.toDB(), 'id = ${body.id}');
    final user = getUser(id: body.id);
    return user;
  }

  void deleteUser(int id) async {
    _dbDriver.delete(usersTableName, 'id = $id');
  }
}
