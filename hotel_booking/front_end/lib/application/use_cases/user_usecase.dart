import 'package:hotel_booking/domain/entities/signup.dart';
import 'package:hotel_booking/domain/entities/user_data.dart';
import 'package:hotel_booking/domain/repositories/user_repository.dart';

class UserUseCase {
  final UserRepository userRepository;

  UserUseCase(this.userRepository);

  Future<void> signup(SignupState signupState) async {
    await userRepository.signup(signupState);
  }

  Future<String> login(String email, String password) async {
    return await userRepository.login(email, password);
  }

  Future<User> getUserById(String userId) async {
    return await userRepository.getUserById(userId);
  }

  Future<void> updateUserName(String userId, String newName) async {
    await userRepository.updateUserName(userId, newName);
  }

  Future<void> updateUserPassword(String userId, String newPassword) async {
    await userRepository.updateUserPassword(userId, newPassword);
  }

  Future<void> logout() async {
    await userRepository.logout();
  }
}