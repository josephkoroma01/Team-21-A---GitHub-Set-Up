import 'package:go_router/go_router.dart';
import 'package:lifebloodworld/features/Login/views/login_screen.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:lifebloodworld/routes/router_const.dart';

class AppRouter {
  GoRouter router = GoRouter(
    
    routes: [
      GoRoute(
        name: 'welcome',
        path: RouteNames.welcomescreen,
        builder: (context, state) =>  WelcomeScreen(),
      ),
      GoRoute(
        name: 'login',
        path: RouteNames.login,
        builder: (context, state) =>  LoginScreen(),
      ),
      // GoRoute(
      //   name: 'login',
      //   path: RouteNames.login,
      //   builder: (context, state) => const MyHomePage(title: 'Labtech'),
      // ),
      
    ],
    
  );
}
