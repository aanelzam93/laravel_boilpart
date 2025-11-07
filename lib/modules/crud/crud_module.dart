import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../data/repositories/item_repository.dart';
import 'crud_controller.dart';
import 'crud_page.dart';

class CrudModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<CrudController>(
      () => CrudController(i.get<ItemRepository>()),
    );
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => BlocProvider(
        create: (_) => Modular.get<CrudController>(),
        child: const CrudPage(),
      ),
    );
  }
}
