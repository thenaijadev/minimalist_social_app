// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:minimalist_social_app/core/usecase/user_usecase.dart';
import 'package:minimalist_social_app/core/utils/typedef.dart';
import 'package:minimalist_social_app/features/users/domain/repositories/user_repository.dart';

class UserUsecase implements UseCase<UserRepository> {
  final UserRepository userRepository;
  UserUsecase({
    required this.userRepository,
  });

  @override
  EitherTrueOrUserError createUserDocument(
      {required String email, required String userName}) {
    return userRepository.createUserDocument(email: email, userName: userName);
  }
}
