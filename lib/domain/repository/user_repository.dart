import '../model/user.dart';

abstract class UserRepository {
  Future<User> createUser({
    required String name,
    required String surname,
    required String email,
    required int gender,
    required DateTime birthdate,
  });

  Future<User> getUser({
    required int id,
  });

  Future<List<User>> getUsers();
}
