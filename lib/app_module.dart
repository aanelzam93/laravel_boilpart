import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/repositories/item_repository.dart';
import 'main.dart' as main;
import 'modules/auth/auth_controller.dart';
import 'modules/auth/auth_module.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    // Core dependencies
    i.addInstance<SharedPreferences>(main.sharedPreferences);
    
    // Repositories
    i.addLazySingleton<ItemRepository>(() => ItemRepository());
    
    // Controllers
    i.addSingleton<AuthController>(
      () => AuthController(i.get<SharedPreferences>()),
    );
  }

  @override
  void routes(r) {
    r.module('/auth', module: AuthModule());
    r.module('/home', module: HomeModule());
    r.redirect('/', to: '/auth/');
  }
}
