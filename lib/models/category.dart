class Category {
  final int? categoryId;
  final String? name;
  Category({this.categoryId, this.name});
}

final planeCategory = Category(
  categoryId: 0,
  name: 'PLANE',
);

final categories = [
  planeCategory,
];
