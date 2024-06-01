import 'package:hotel_booking/domain/entities/signup.dart';
import 'package:hotel_booking/domain/entities/user_data.dart';
import 'package:hotel_booking/domain/repositories/user_repository.dart';
import 'package:hotel_booking/infrastructure/repositories/remote_data_resource/user_remote_data_resource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> signup(SignupState signupState) async {
    await remoteDataSource.signup(signupState);
  }

  @override
  Future<String> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }

  @override
  Future<User> getUserById(String userId) async {
    return await remoteDataSource.getUserById(userId);
  }

  @override
  Future<void> updateUserName(String userId, String newName) async {
    await remoteDataSource.updateUserName(userId, newName);
  }

  @override
  Future<void> updateUserPassword(String userId, String newPassword) async {
    await remoteDataSource.updateUserPassword(userId, newPassword);
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }
}