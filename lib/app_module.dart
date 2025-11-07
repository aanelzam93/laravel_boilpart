import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/dio_client.dart';
import 'data/repositories/item_repository.dart';
import 'data/services/auth_service.dart';
import 'data/services/user_service.dart';
import 'data/services/product_service.dart';
import 'data/services/post_service.dart';
import 'main.dart' as main;
import 'modules/auth/auth_controller.dart';
import 'modules/auth/auth_module.dart';
import 'modules/home/home_controller.dart';
import 'modules/home/home_module.dart';
import 'modules/blog/blog_controller.dart';
import 'modules/blog/blog_module.dart';
import 'modules/article/article_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    // Core dependencies
    i.addInstance<SharedPreferences>(main.sharedPreferences);

    // Network client
    i.addLazySingleton<DioClient>(() => DioClient());

    // API Services
    i.addLazySingleton<AuthService>(
      () => AuthService(i.get<DioClient>()),
    );
    i.addLazySingleton<UserService>(
      () => UserService(i.get<DioClient>()),
    );
    i.addLazySingleton<ProductService>(
      () => ProductService(i.get<DioClient>()),
    );
    i.addLazySingleton<PostService>(
      () => PostService(i.get<DioClient>()),
    );

    // Repositories
    i.addLazySingleton<ItemRepository>(() => ItemRepository());

    // Controllers
    i.addSingleton<AuthController>(
      () => AuthController(
        i.get<SharedPreferences>(),
        i.get<AuthService>(),
      ),
    );
    i.addLazySingleton<HomeController>(
      () => HomeController(
        productService: i.get<ProductService>(),
      ),
    );
    i.addLazySingleton<BlogController>(
      () => BlogController(
        postService: i.get<PostService>(),
      ),
    );
  }

  @override
  void routes(r) {
    r.module('/auth', module: AuthModule());
    r.module('/home', module: HomeModule());
    r.module('/blog', module: BlogModule());
    r.module('/article', module: ArticleModule());
    r.redirect('/', to: '/home/');
  }
}
