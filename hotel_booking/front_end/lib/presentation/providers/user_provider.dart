import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/domain/entities/user_data.dart';




// Define a Riverpod provider for the user
final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier(User(
    name: 'John Doe',
    email: 'johndoe@example.com',
    password: 'password', 
    id: '1324retdfgvbne4', role: 'admin',
  ));
});

// Define a StateNotifier class for the user
class UserNotifier extends StateNotifier<User> {
  UserNotifier(User state) : super(state);

  // Update user's name
  void setName(String newName) {
    state = state.copyWith(name: newName);
  }

  // Update user's email
  void setEmail(String newEmail) {
    state = state.copyWith(email: newEmail);
  }

  // Update user's password
  void setPassword(String newPassword) {
    state = state.copyWith(password: newPassword);
  }
}
