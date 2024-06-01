
import 'package:hotel_booking/domain/entities/signup.dart';
import 'package:hotel_booking/domain/entities/user_data.dart';

abstract class UserRepository {
  Future<void> signup(SignupState signupState);
  Future<String> login(String email, String password);
  Future<User> getUserById(String userId);
  Future<void> updateUserName(String userId, String newName);
  Future<void> updateUserPassword(String userId, String newPassword);
  Future<void> logout();
}