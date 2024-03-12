import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:minimalist_social_app/config/router/app_router.dart';
import 'package:minimalist_social_app/config/router/routes.dart';
import 'package:minimalist_social_app/config/theme/dark_theme.dart';
import 'package:minimalist_social_app/config/theme/light_theme.dart';
import 'package:minimalist_social_app/core/connection/network_info.dart';
import 'package:minimalist_social_app/core/firebase/firebase_options.dart';
import 'package:minimalist_social_app/features/auth/data/datasources/local/local_user_data_source.dart';
import 'package:minimalist_social_app/features/auth/data/datasources/remote/firebase_auth_service.dart';
import 'package:minimalist_social_app/features/auth/data/datasources/remote/local_auth_service.dart';
import 'package:minimalist_social_app/features/auth/data/repositories/firebase_auth_repository_implementation.dart';
import 'package:minimalist_social_app/features/auth/data/repositories/local_auth_repository_implementation.dart';
import 'package:minimalist_social_app/features/auth/domain/usecases/auth_usecases.dart';
import 'package:minimalist_social_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:minimalist_social_app/features/dark_mode/presentation/bloc/dark_mode_bloc.dart';
import 'package:minimalist_social_app/features/home/data/provider/message_provider.dart';
import 'package:minimalist_social_app/features/home/data/repositories/message_repository.dart';
import 'package:minimalist_social_app/features/home/presentation/bloc/message_bloc.dart';
import 'package:minimalist_social_app/features/users/bloc/user_bloc.dart';
import 'package:minimalist_social_app/features/users/data/providers/user_provider.dart';
import 'package:minimalist_social_app/features/users/data/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  appInitialization();
  runApp(const MyApp());
}

appInitialization() async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.initFlutter();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DarkModeBloc(),
          ),
          BlocProvider(
            create: (context) => UserBloc(
              userRepository: UserRepository(
                provider: UsersProvider(db: FirebaseFirestore.instance),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => AuthBloc(
              authUsecase: AuthUsecase(
                localAuthRepository: LocalAuthRepositoryImplementation(
                    authService: LocalAuthServiceImplementation(
                        auth: LocalAuthentication())),
                authRepository: FirebaseAuthRepositoryImplementation(
                  networkInfo: NetworkInfoImpl(
                    connectionChecker: DataConnectionChecker(),
                  ),
                  authService: FirebaseAuthServiceImlementation(),
                  localAuthUserSource: AuthUserLocalDataSourceImpl(
                    sharedPreferences: SharedPreferences.getInstance(),
                  ),
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => MessageBloc(
              repo: MessageRepository(
                provider: MessageProvider(db: FirebaseFirestore.instance),
              ),
            ),
          ),
        ],
        child: BlocBuilder<DarkModeBloc, DarkModeState>(
          builder: (context, state) {
            if (state is DarkModeCurrentState) {
              return MaterialApp(
                theme: state.isDark ? darkTheme() : lightTheme(),
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                initialRoute: Routes.landing,
                onGenerateRoute: appRouter.onGenerateRoute,
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
