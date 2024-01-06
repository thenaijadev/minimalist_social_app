import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimalist_social_app/config/router/routes.dart';
import 'package:minimalist_social_app/core/widgets/loading_widget.dart';
import 'package:minimalist_social_app/features/auth/presentation/bloc/auth_bloc.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    context.read<AuthBloc>().add(const AuthEventGetCurrentUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateIsLoggedIn) {
            if (state.user.isEmailVerified == false) {
              Navigator.pushReplacementNamed(context, Routes.emailVerification);
            } else {
              Navigator.pushReplacementNamed(context, Routes.home);
            }
          }
          if (state is AuthStateAuthError) {
            Navigator.pushReplacementNamed(context, Routes.login);
          }
        },
        builder: (context, state) {
          return const Center(
              child: LoadingWidget(
            size: 100,
          ));
        },
      ),
    );
  }
}
