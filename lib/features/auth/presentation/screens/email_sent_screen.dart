import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:minimalist_social_app/core/widgets/text_widget.dart';
import 'package:minimalist_social_app/features/auth/presentation/widgets/form_button.dart';

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
          child: Padding(
            padding: const EdgeInsets.all(10.0).copyWith(top: 0),
            child: Column(
              children: [
                Lottie.asset('images/email_sent.json'),
                TextWidget(
                  text:
                      "A password reset link has been sent to your email. Reset your password and then come back to log in.",
                  color: Theme.of(context).colorScheme.inversePrimary,
                  textAlign: TextAlign.center,
                ),
                const Gap(20),
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
    );
  }
}
