import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimalist_social_app/config/router/routes.dart';
import 'package:minimalist_social_app/core/widgets/dark_mode_switch.dart';
import 'package:minimalist_social_app/core/widgets/loading_widget.dart';
import 'package:minimalist_social_app/core/widgets/text_widget.dart';
import 'package:minimalist_social_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:minimalist_social_app/features/home/presentation/widgets/my_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        actions: [
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthStateIsNotLoggedIn) {
                Navigator.popAndPushNamed(context, Routes.landing);
              }
            },
            builder: (context, state) {
              return state is AuthStateIsLoading
                  ? const LoadingWidget()
                  : IconButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(const AuthEventLogout());
                      },
                      icon: Icon(
                        Icons.logout,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    );
            },
          ),
          const DarkModeSwitch(),
        ],
        backgroundColor: Theme.of(context).colorScheme.background,
        title: TextWidget(
          text: "The Wall",
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: const MyDrawer(),
      body: const Center(child: Text("Home Screen")),
    );
  }
}
