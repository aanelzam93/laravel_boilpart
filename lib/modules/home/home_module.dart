import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../crud/crud_module.dart';
import '../profile/profile_module.dart';
import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => BlocProvider.value(
        value: Modular.get<HomeController>()..loadData(),
        child: const HomePage(),
      ),
    );
    r.module('/crud', module: CrudModule());
    r.module('/profile', module: ProfileModule());
  }
}
