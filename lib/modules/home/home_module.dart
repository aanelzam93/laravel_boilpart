import 'package:flutter_modular/flutter_modular.dart';
import '../crud/crud_module.dart';
import '../profile/profile_module.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
    r.module('/crud', module: CrudModule());
    r.module('/profile', module: ProfileModule());
  }
}
