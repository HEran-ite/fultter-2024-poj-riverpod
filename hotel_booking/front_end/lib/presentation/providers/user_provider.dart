import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hotel_booking/application/use_cases/user_api_provider.dart';
import 'package:hotel_booking/domain/entities/signup.dart';
import 'package:hotel_booking/domain/entities/user_data.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserNotifier extends StateNotifier<User> {
  final UserApi userApi;
  final FlutterSecureStorage storage = FlutterSecureStorage();

  UserNotifier(this.userApi) : super(User(id: '', name: '', email: '', password: '', role: ''));

  // Method to update user from token
  void updateUserFromToken(String token) {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      state = User(
        id: decodedToken['id'] ?? '',
        name: decodedToken['name'] ?? '',
        email: decodedToken['email'] ?? '',
        password: state.password, // Assuming the password remains the same
        role: decodedToken['role'] ?? '',
      );
      print('User state after token update: $state'); // Debugging statement
    } catch (e) {
      print('Error decoding token: $e');
    }
  }

  // Method to fetch token from secure storage and update user state
  Future<void> fetchAndSetUser() async {
    String? token = await storage.read(key: 'user_token');
    if (token != null && token.isNotEmpty) {
      print('Fetched token from storage: $token'); // Debugging print statement
      updateUserFromToken(token);
    } else {
      print('No token found in secure storage or token is empty');
      state = User(id: '', name: '', email: '', password: '', role: '');
    }
  }

  // Method to login a user
  Future<void> login(String email, String password) async {
    try {
      final token = await userApi.login(email, password);
      await storage.write(key: 'user_token', value: token);
      updateUserFromToken(token);
    } catch (e) {
      print('Error logging in: $e');
      rethrow;
    }
  }

  // Method to signup a user
  Future<void> signup(SignupState signupState) async {
    try {
      await userApi.signup(signupState);
      final token = await userApi.login(signupState.email!, signupState.password);
      await storage.write(key: 'user_token', value: token);
      updateUserFromToken(token);
    } catch (e) {
      print('Error signing up: $e');
      rethrow;
    }
  }

  // Clear user state and notify listeners
  Future<void> logout() async {
    await storage.delete(key: 'user_token');
    state = User(id: '', name: '', email: '', password: '', role: '');
    print('User state after logout: $state'); // Debugging print statement
  }

  // Update user's name
  Future<void> setName(String newName) async {
    final token = await storage.read(key: 'user_token');
    if (token != null) {
      try {
        await userApi.updateUserName(state.id, newName);
        state = state.copyWith(name: newName);
      } catch (e) {
        print('Error setting name: $e');
      }
    }
  }

  // Update user's password
  Future<void> setPassword(String newPassword) async {
    final token = await storage.read(key: 'user_token');
    if (token != null) {
      try {
        await userApi.updateUserPassword(state.id, newPassword);
        state = state.copyWith(password: newPassword);
      } catch (e) {
        print('Error setting password: $e');
      }
    }
  }
}

// Define a Riverpod provider for the user
final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  final userApi = ref.read(userApiProvider);
  final notifier = UserNotifier(userApi);
  notifier.fetchAndSetUser(); // Fetch and set the user information when the notifier is created
  return notifier;
});