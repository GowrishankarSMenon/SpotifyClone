import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:music_app/core/configs/themes/app_theme.dart';
import 'package:music_app/duplicateRemover.dart';
import 'package:music_app/firebase_options.dart';
import 'package:music_app/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:music_app/presentation/splash/pages/splash.dart';
import 'package:music_app/service_locator.dart';
import 'package:path_provider/path_provider.dart';
import 'uploader.dart';  // Import the uploader.dart file

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  HydratedBloc.storage = storage;

  // Set up full-screen mode globally
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  await initializeDependencies();

  // Call the uploadSongsMetadata method on app startup
  final uploader = UploaderAndFixer();
  await uploader.fixAndUpload();

  final remover = DuplicateRemover();
  await remover.removeDuplicates();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) => MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: mode,
          debugShowCheckedModeBanner: false,
          home: const SplashPage(),
        ),
      ),
    );
  }
}
