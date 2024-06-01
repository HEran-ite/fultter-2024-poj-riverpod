import 'package:hotel_booking/domain/entities/user_data.dart';

abstract class UserLocalDataSource {
  Future<User> fetchUser(String id);
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String id);
}