import 'package:flutter/material.dart';
import 'package:flutter_auth_app/features/auth/data/repo/auth_repo.dart';
import 'package:flutter_auth_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/network/api_client.dart';
import 'core/storage/secure_storage_service.dart';
import 'features/onboarding/screens/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final secureStorage = SecureStorageService();
    final apiClient = ApiClient(secureStorage);
    final authRepository = AuthRepository(apiClient, secureStorage);
    return BlocProvider(
      create: (context) => AuthBloc(authRepository),
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'inter'),
        home: WelcomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
