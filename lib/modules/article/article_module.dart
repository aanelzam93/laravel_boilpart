import 'package:flutter_modular/flutter_modular.dart';
import 'write_article_page.dart';

class ArticleModule extends Module {
  @override
  void routes(r) {
    r.child(
      '/write',
      child: (context) => const WriteArticlePage(),
    );
    r.child(
      '/edit/:id',
      child: (context) {
        final id = int.tryParse(r.args.params['id'] ?? '0') ?? 0;
        return WriteArticlePage(articleId: id);
      },
    );
  }
}
