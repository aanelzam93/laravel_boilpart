import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/dio_client.dart';
import '../storage/local_storage.dart';
import '../localization/language_cubit.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  
  // Core
  getIt.registerLazySingleton<LocalStorage>(
    () => LocalStorage(getIt<SharedPreferences>()),
  );
  
  getIt.registerLazySingleton<DioClient>(
    () => DioClient(),
  );
  
  // Cubits
  getIt.registerFactory<LanguageCubit>(
    () => LanguageCubit(getIt<LocalStorage>()),
  );
  
  // Add your repositories and use cases here
}
