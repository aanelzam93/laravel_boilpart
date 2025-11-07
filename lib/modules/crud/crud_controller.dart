import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/item_model.dart';
import '../../data/repositories/item_repository.dart';

// States
abstract class CrudState {}

class CrudInitial extends CrudState {}

class CrudLoading extends CrudState {}

class CrudLoaded extends CrudState {
  final List<ItemModel> items;
  CrudLoaded(this.items);
}

class CrudError extends CrudState {
  final String message;
  CrudError(this.message);
}

// Cubit
class CrudController extends Cubit<CrudState> {
  final ItemRepository repository;

  CrudController(this.repository) : super(CrudInitial()) {
    loadItems();
  }

  void loadItems() {
    emit(CrudLoading());
    try {
      final items = repository.getAll();
      emit(CrudLoaded(items));
    } catch (e) {
      emit(CrudError(e.toString()));
    }
  }

  void addItem(String name, String description) {
    final item = ItemModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      description: description,
    );
    repository.add(item);
    loadItems();
  }

  void updateItem(String id, String name, String description) {
    final item = ItemModel(
      id: id,
      name: name,
      description: description,
    );
    repository.update(item);
    loadItems();
  }

  void deleteItem(String id) {
    repository.delete(id);
    loadItems();
  }
}
