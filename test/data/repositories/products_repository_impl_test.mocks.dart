// Mocks generated by Mockito 5.4.4 from annotations
// in products_app/test/data/repositories/products_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:products_app/products/data/datasources/products_datasource.dart'
    as _i4;
import 'package:products_app/products/data/models/products/product_model.dart' as _i6;
import 'package:products_app/products/data/models/products/products_model.dart' as _i2;
import 'package:products_app/products/domain/entities/products/product_details.dart'
    as _i7;
import 'package:products_app/products/domain/entities/products/products.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeProductsModel_0 extends _i1.SmartFake implements _i2.ProductsModel {
  _FakeProductsModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeProducts_1 extends _i1.SmartFake implements _i3.Products {
  _FakeProducts_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ProductsDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockProductsDatasource extends _i1.Mock
    implements _i4.ProductsDatasource {
  @override
  _i5.Future<_i2.ProductsModel> getProducts() => (super.noSuchMethod(
        Invocation.method(
          #getProducts,
          [],
        ),
        returnValue: _i5.Future<_i2.ProductsModel>.value(_FakeProductsModel_0(
          this,
          Invocation.method(
            #getProducts,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i2.ProductsModel>.value(_FakeProductsModel_0(
          this,
          Invocation.method(
            #getProducts,
            [],
          ),
        )),
      ) as _i5.Future<_i2.ProductsModel>);
}

/// A class which mocks [ProductsModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockProductsModel extends _i1.Mock implements _i2.ProductsModel {
  @override
  List<_i6.ProductModel> get products => (super.noSuchMethod(
        Invocation.getter(#products),
        returnValue: <_i6.ProductModel>[],
        returnValueForMissingStub: <_i6.ProductModel>[],
      ) as List<_i6.ProductModel>);

  @override
  int get total => (super.noSuchMethod(
        Invocation.getter(#total),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  int get skip => (super.noSuchMethod(
        Invocation.getter(#skip),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  int get limit => (super.noSuchMethod(
        Invocation.getter(#limit),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  Map<String, dynamic> toJson() => (super.noSuchMethod(
        Invocation.method(
          #toJson,
          [],
        ),
        returnValue: <String, dynamic>{},
        returnValueForMissingStub: <String, dynamic>{},
      ) as Map<String, dynamic>);

  @override
  _i3.Products toEntity() => (super.noSuchMethod(
        Invocation.method(
          #toEntity,
          [],
        ),
        returnValue: _FakeProducts_1(
          this,
          Invocation.method(
            #toEntity,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeProducts_1(
          this,
          Invocation.method(
            #toEntity,
            [],
          ),
        ),
      ) as _i3.Products);
}

/// A class which mocks [Products].
///
/// See the documentation for Mockito's code generation for more information.
class MockProducts extends _i1.Mock implements _i3.Products {
  @override
  List<_i7.ProductDetails> get productsDetails => (super.noSuchMethod(
        Invocation.getter(#productsDetails),
        returnValue: <_i7.ProductDetails>[],
        returnValueForMissingStub: <_i7.ProductDetails>[],
      ) as List<_i7.ProductDetails>);

  @override
  List<Object?> get props => (super.noSuchMethod(
        Invocation.getter(#props),
        returnValue: <Object?>[],
        returnValueForMissingStub: <Object?>[],
      ) as List<Object?>);
}
