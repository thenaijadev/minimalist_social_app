import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:minimalist_social_app/config/router/routes.dart';
import 'package:minimalist_social_app/core/widgets/loading_widget.dart';
import 'package:minimalist_social_app/core/widgets/snackbar.dart';
import 'package:minimalist_social_app/core/widgets/text_widget.dart';
import 'package:minimalist_social_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:minimalist_social_app/features/auth/presentation/widgets/form_button.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0).copyWith(top: 0),
            child: Column(
              children: [
                BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  return state is AuthStateEmailVerificationLinkSent
                      ? Lottie.asset('images/email_sent.json')
                      : Image.asset(
                          'images/mail.png',
                          width: 250,
                        );
                }),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return state is AuthStateEmailVerificationLinkSent
                        ? TextWidget(
                            text:
                                "An email verification link has been sent to your email. Verify your email and then come back to log in.",
                            color: Theme.of(context).colorScheme.inversePrimary,
                            textAlign: TextAlign.center,
                          )
                        : TextWidget(
                            text:
                                "An email verification link will be sent to your email. Verify your email and then come back to log in.",
                            color: Theme.of(context).colorScheme.inversePrimary,
                            textAlign: TextAlign.center,
                          );
                  },
                ),
                const Gap(20),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthStateAuthError) {
                      InfoSnackBar.showErrorSnackBar(
                          context, state.authError.message);
                    }
                  },
                  builder: (context, state) {
                    return state is AuthStateIsLoading
                        ? const LoadingWidget()
                        : state is AuthStateEmailVerificationLinkSent
                            ? FormButton(
                                label: "Login",
                                onTap: () {
                                  Navigator.of(context)
                                      .popAndPushNamed(Routes.login);
                                },
                              )
                            : FormButton(
                                label: "Send verification link",
                                onTap: () {
                                  context.read<AuthBloc>().add(
                                        const AuthEventSendEmailVerification(),
                                      );
                                },
                              );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
