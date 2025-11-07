import '../models/item_model.dart';

class ItemRepository {
  final List<ItemModel> _items = [];

  List<ItemModel> getAll() {
    return List.unmodifiable(_items);
  }

  ItemModel? getById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  void add(ItemModel item) {
    _items.add(item);
  }

  void update(ItemModel item) {
    final index = _items.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      _items[index] = item;
    }
  }

  void delete(String id) {
    _items.removeWhere((item) => item.id == id);
  }

  void clear() {
    _items.clear();
  }
}
