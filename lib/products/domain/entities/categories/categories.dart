
import 'package:equatable/equatable.dart';

import 'package:products_app/products/domain/entities/categories/category.dart';

class Categories extends Equatable{
  final List<Category> categories;

  const Categories({
    required this.categories,
  });

  @override
  List<Object?> get props => [
        categories,
      ];
}