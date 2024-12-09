import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_route_const.dart';
import '../shared/navigator_keys.dart';
import '../shared/utils/custom_transition.dart';
import '../views/pages/history/history_view.dart';
import '../views/pages/home/home_view.dart';
import '../views/pages/login/login_view.dart';

GoRouter createRouter() {
  return GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: AppRouteConst.login,
        name: 'login',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const Loginview(),
          transitionsBuilder: (_, animation, __, child) =>
              CustomTransitions.slideFromRight(child, animation),
        ),
      ),
      GoRoute(
        path: AppRouteConst.home,
        name: 'home',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const HomeView(),
          transitionsBuilder: (_, animation, __, child) =>
              CustomTransitions.slideFromRight(child, animation),
        ),
      ),
      GoRoute(
        path: AppRouteConst.history,
        name: 'history',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const HistoryView(),
          transitionsBuilder: (_, animation, __, child) =>
              CustomTransitions.slideFromRight(child, animation),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => _errorNotFoundPages(),
    initialLocation: AppRouteConst.login,
    debugLogDiagnostics: true,
    routerNeglect: true,
  );
}

MaterialPage<dynamic> _errorNotFoundPages() {
  return MaterialPage(
    child: Scaffold(
      appBar: AppBar(title: const Text('404')),
      body: const Center(child: Text('Page Not Found')),
    ),
  );
}
