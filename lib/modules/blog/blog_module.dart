import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'blog_controller.dart';
import 'blog_page.dart';
import 'post_detail_page.dart';

class BlogModule extends Module {
  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => BlocProvider.value(
        value: Modular.get<BlogController>()..loadData(),
        child: const BlogPage(),
      ),
    );
    r.child(
      '/detail/:id',
      child: (context) {
        final id = int.tryParse(r.args.params['id'] ?? '0') ?? 0;
        return PostDetailPage(postId: id);
      },
    );
  }
}
