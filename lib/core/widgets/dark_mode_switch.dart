import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimalist_social_app/features/dark_mode/presentation/bloc/dark_mode_bloc.dart';

class DarkModeSwitch extends StatelessWidget {
  const DarkModeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: .8,
      child:
          BlocBuilder<DarkModeBloc, DarkModeState>(builder: (context, state) {
        return state is DarkModeCurrentState
            ? Switch(
                activeColor: Colors.black,
                activeThumbImage: const AssetImage("images/moon.png"),
                inactiveThumbImage: const AssetImage("images/sun.png"),
                activeTrackColor: const Color.fromARGB(255, 20, 20, 20),
                value: state.isDark,
                onChanged: (value) {
                  context
                      .read<DarkModeBloc>()
                      .add(ToggleDarkModeEvent(isDark: !state.isDark));
                },
              )
            : const SizedBox();
      }),
    );
  }
}
