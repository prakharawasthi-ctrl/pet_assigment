import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/core/themes/app_theme.dart';
import 'package:pet_adoption_app/data/datasources/local_storage.dart';
import 'package:pet_adoption_app/data/datasources/pet_api.dart';
import 'package:pet_adoption_app/data/repositories/pet_repository_impl.dart';
import 'package:pet_adoption_app/presentation/blocs/pet_bloc.dart';
import 'package:pet_adoption_app/presentation/blocs/theme_bloc.dart';
import 'package:pet_adoption_app/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    print('🚀 Starting app initialization...');
    
    // Initialize LocalStorage (SharedPreferences)
    await LocalStorage.initialize();
    
    print('✅ App initialized successfully');
    
    runApp(const MyApp());
  } catch (e) {
    print('❌ Error initializing app: $e');
    runApp(const ErrorApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => PetBloc(
            repository: PetRepositoryImpl(
              apiDataSource: PetApiDataSource(),
              localDataSource: LocalStorage(),
            ),
          )..add(LoadPetsEvent()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Pet Adoption App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            home: const HomePage(),
            // Add this for debugging - temporarily replace with StorageTestWidget
            // home: const StorageTestWidget(),
          );
        },
      ),
    );
  }
}

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text(
                'Failed to initialize app',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Please restart the app'),
            ],
          ),
        ),
      ),
    );
  }
}