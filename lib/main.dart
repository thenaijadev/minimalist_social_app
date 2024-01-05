import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:minimalist_social_app/config/router/app_router.dart';
import 'package:minimalist_social_app/config/router/routes.dart';
import 'package:minimalist_social_app/config/theme/dark_theme.dart';
import 'package:minimalist_social_app/config/theme/light_theme.dart';
import 'package:minimalist_social_app/features/dark_mode/presentation/bloc/dark_mode_bloc.dart';
import 'package:minimalist_social_app/core/firebase/firebase_options.dart';

void main() async {
  appInitialization();
  runApp(const MyApp());
}

appInitialization() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
        ],
        child: BlocBuilder<DarkModeBloc, DarkModeState>(
          builder: (context, state) {
            if (state is DarkModeCurrentState) {
              return MaterialApp(
                theme: state.isDark ? darkTheme() : lightTheme(),
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                initialRoute: Routes.login,
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
