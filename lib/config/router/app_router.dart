import 'package:go_router/go_router.dart';
import 'package:isp/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/post', // ruta para la pantalla de creación de reportes
      name: PostScreen.name,
      builder: (context, state) => const PostScreen(),
    ),
  ],
);
