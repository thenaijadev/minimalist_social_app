import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:minimalist_social_app/config/router/routes.dart';
import 'package:minimalist_social_app/core/validator/validator.dart';
import 'package:minimalist_social_app/core/widgets/text_widget.dart';
import 'package:minimalist_social_app/features/auth/presentation/widgets/form_button.dart';
import 'package:minimalist_social_app/features/auth/presentation/widgets/input_field_widget.dart';
import 'package:minimalist_social_app/features/dark_mode/presentation/bloc/dark_mode_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();
  bool? emailState = false;
  bool? passwordState = false;
  bool enabled = false;
  bool obscureText = true;
  bool? checkBoxValue = false;
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
                  Icon(Icons.person,
                      size: 80,
                      color: Theme.of(context).colorScheme.inversePrimary),
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
                  InputFieldWidget(
                    textFieldkey: passwordKey,
                    obscureText: obscureText,
                    label: "Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: Icon(obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    hintText: "e.g: Password5&",
                    onChanged: (val) {
                      setState(() {
                        emailState = passwordKey.currentState?.validate();
                      });
                    },
                    validator: (val) {
                      final emailState = Validator.validatePassword(
                          passwordKey.currentState?.value);
                      return emailState;
                    },
                    enabledBorderRadius: 10,
                    hintColor: Theme.of(context).colorScheme.secondary,
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.forgotPassword);
                        },
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  FormButton(
                    label: "Login",
                    onTap: () {},
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: TextWidget(
                          fontWeight: FontWeight.w300,
                          text: "Dont have an account?",
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextWidget(
                        onTap: () {
                          Navigator.of(context).pushNamed(Routes.register);
                        },
                        fontWeight: FontWeight.bold,
                        text: "Register",
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ],
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
