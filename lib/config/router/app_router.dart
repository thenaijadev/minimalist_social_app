import 'package:flutter/material.dart';
import 'package:minimalist_social_app/config/router/routes.dart';
import 'package:minimalist_social_app/core/widgets/error_screen.dart';
import 'package:minimalist_social_app/features/auth/presentation/screens/login_screen.dart';
import 'package:minimalist_social_app/features/auth/presentation/screens/registration_screen.dart';
import 'package:minimalist_social_app/features/auth/presentation/screens/forgot_password_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    // logger.i("This is the route: ${routeSettings.name}");
    switch (routeSettings.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => const RegistrationScreen(),
        );
      case Routes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
        );
      // case Routes.registration:
      //   return MaterialPageRoute(
      //     builder: (_) => const RegistrationScreen(),
      //   );
      // case Routes.login:
      //   return MaterialPageRoute(
      //     builder: (_) => const LoginScreen(),
      //   );

      // case Routes.home:
      //   return MaterialPageRoute(
      //     builder: (_) => const HomeScreen(),
      //   );

      // case Routes.soups:
      //   var data = routeSettings.arguments as List<MealItemModel>;
      //   return MaterialPageRoute(
      //     builder: (_) => SoupsScreen(mealList: data),
      //   );

      // case Routes.meats:
      //   var data = routeSettings.arguments as List<MealItemModel>;

      //   return MaterialPageRoute(
      //     builder: (_) => MeatScreen(mealList: data),
      //   );

      // case Routes.drinks:
      //   var data = routeSettings.arguments as List<MealItemModel>;

      //   return MaterialPageRoute(
      //     builder: (_) => DrinksScreen(mealList: data),
      //   );
      // case Routes.cart:
      //   return MaterialPageRoute(
      //     builder: (_) => const CartScreen(),
      //   );
      // case Routes.payment:
      //   return MaterialPageRoute(
      //     builder: (_) => const AddNewCardScreen(),
      //   );
      // case Routes.foodType:
      //   var data = routeSettings.arguments as Food;
      //   return MaterialPageRoute(
      //     builder: (_) => FoodTypeScreen(
      //       food: data,
      //     ),
      //   );
      // case Routes.verifyPhoneNo:
      //   return MaterialPageRoute(
      //     builder: (_) => const PhoneNumberScreen(),
      //   );
      default:
        return MaterialPageRoute(
          builder: (_) => const ErrorScreen(),
        );
    }
  }
}
