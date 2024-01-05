import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:minimalist_social_app/core/validator/validator.dart';
import 'package:minimalist_social_app/core/widgets/loading_widget.dart';
import 'package:minimalist_social_app/core/widgets/snackbar.dart';
import 'package:minimalist_social_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:minimalist_social_app/features/auth/presentation/widgets/form_button.dart';
import 'package:minimalist_social_app/features/auth/presentation/widgets/input_field_widget.dart';
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
                  const Gap(
                    25,
                  ),
                  InputFieldWidget(
                    textFieldkey: emailKey,
                    label: "Your email address",
                    hintText: "e.g:mark@gmail.com",
                    onChanged: (val) {
                      setState(() {
                        emailState = emailKey.currentState?.validate();
                      });
                    },
                    validator: (val) {
                      final emailState =
                          Validator.validateEmail(emailKey.currentState?.value);
                      return emailState;
                    },
                    enabledBorderRadius: 10,
                    hintColor: Theme.of(context).colorScheme.secondary,
                  ),
                  const Gap(25),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthStateAuthError) {
                        InfoSnackBar.showErrorSnackBar(
                            context, state.authError.message);
                      }
                      if (state is AuthStatePasswordResetSent) {
                        Navigator.of(context).pop();
                      }
                    },
                    builder: (context, state) {
                      return state is AuthStateIsLoading
                          ? const LoadingWidget()
                          : FormButton(
                              label: "Send reset instructions",
                              onTap: () {
                                if (emailState!) {
                                  context.read<AuthBloc>().add(
                                        AuthEventSendPasswordReset(
                                          toEmail: emailKey.currentState?.value,
                                        ),
                                      );
                                }
                              },
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
