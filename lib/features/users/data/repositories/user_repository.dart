import 'package:minimalist_social_app/core/utils/typedef.dart';
import 'package:minimalist_social_app/features/users/data/providers/user_provider.dart';
import 'package:minimalist_social_app/features/users/data/users/user_model.dart';

class UserRepository {
  UserRepository({required this.provider});
  final UsersProvider provider;

  EitherBoolOrUserError createUser(UserModel message) {
    return provider.createUser(message);
  }

  Future<EitherBoolOrUserError> deleteUser(String userId) async {
    return provider.deleteUser(userId);
  }

  Future<EitherBoolOrUserError> updateData(
      {required Map<String, dynamic> userDetails}) async {
    return provider.updateUser(userDetails: userDetails);
  }
}
