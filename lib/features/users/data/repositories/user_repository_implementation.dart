// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:minimalist_social_app/core/connection/network_info.dart';
import 'package:minimalist_social_app/core/utils/typedef.dart';
import 'package:minimalist_social_app/features/auth/data/datasources/remote/firebase_auth_service.dart';
import 'package:minimalist_social_app/features/users/data/datasources/local/local_user_data_source.dart';
import 'package:minimalist_social_app/features/users/data/datasources/remote/user_service.dart';
import 'package:minimalist_social_app/features/users/data/models/user_model.dart';
import 'package:minimalist_social_app/features/users/domain/repositories/user_repository.dart';

class UserRepositoryImplementation implements UserRepository {
  final NetworkInfo networkInfo;
  final UserService userService;
  final FirebaseAuthService authService;
  final UserLocalDataSource localUserDataSource;
  UserRepositoryImplementation(
      {required this.userService,
      required this.networkInfo,
      required this.authService,
      required this.localUserDataSource});

  @override
  EitherTrueOrUserError createUserDocument(
      {required String email, required String userName}) async {
    UserModel.fromMap({"email": email, "userName": userName});
    // await localUserDataSource.saveUser(user);
    return userService.createUserDocument(email: email, userName: userName);
  }
}
