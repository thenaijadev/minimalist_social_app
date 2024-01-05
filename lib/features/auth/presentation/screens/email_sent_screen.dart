import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:minimalist_social_app/features/auth/presentation/widgets/form_button.dart';
import 'package:minimalist_social_app/features/dark_mode/presentation/bloc/dark_mode_bloc.dart';

class EmailSentScreen extends StatefulWidget {
  const EmailSentScreen({super.key});

  @override
  State<EmailSentScreen> createState() => _EmailSentScreenState();
}

class _EmailSentScreenState extends State<EmailSentScreen> {
  final formKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormFieldState>();
  final usernameKey = GlobalKey<FormFieldState>();

  final passwordKey = GlobalKey<FormFieldState>();
  final confirmPasswordKey = GlobalKey<FormFieldState>();

  bool? emailState = false;
  bool? passwordState = false;
  bool? confirmPasswordState = false;
  bool? usernameState = false;

  bool enabled = false;
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Transform.scale(
                    scale: .8,
                    child: BlocBuilder<DarkModeBloc, DarkModeState>(
                        builder: (context, state) {
                      return state is DarkModeCurrentState
                          ? Switch(
                              activeColor: Colors.black,
                              activeThumbImage:
                                  const AssetImage("images/moon.png"),
                              inactiveThumbImage:
                                  const AssetImage("images/sun.png"),
                              activeTrackColor:
                                  const Color.fromARGB(255, 20, 20, 20),
                              value: state.isDark,
                              onChanged: (value) {
                                context.read<DarkModeBloc>().add(
                                    ToggleDarkModeEvent(isDark: !state.isDark));
                              },
                            )
                          : const SizedBox();
                    }),
                  ),
                  Lottie.asset('images/email_sent.json'),
                  FormButton(
                    label: "Login",
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
