// Mocks generated by Mockito 5.4.4 from annotations
// in products_app/test/presentation/notifiers/products_page_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:fpdart/fpdart.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i8;
import 'package:products_app/core/errors/failures.dart' as _i6;
import 'package:products_app/core/usecases/use_case.dart' as _i7;
import 'package:products_app/products/data/models/product_model.dart' as _i10;
import 'package:products_app/products/data/models/products_model.dart' as _i9;
import 'package:products_app/products/domain/entities/product_details.dart'
    as _i11;
import 'package:products_app/products/domain/entities/products.dart' as _i2;
import 'package:products_app/products/domain/usecases/get_products_use_case.dart'
    as _i3;

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

class _FakeProducts_0 extends _i1.SmartFake implements _i2.Products {
  _FakeProducts_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetProductsUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetProductsUseCase extends _i1.Mock
    implements _i3.GetProductsUseCase {
  @override
  _i4.Future<_i5.Either<_i6.Failure, _i2.Products>> call(
          _i7.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i4.Future<_i5.Either<_i6.Failure, _i2.Products>>.value(
            _i8.dummyValue<_i5.Either<_i6.Failure, _i2.Products>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i5.Either<_i6.Failure, _i2.Products>>.value(
                _i8.dummyValue<_i5.Either<_i6.Failure, _i2.Products>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i4.Future<_i5.Either<_i6.Failure, _i2.Products>>);
}

/// A class which mocks [ProductsModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockProductsModel extends _i1.Mock implements _i9.ProductsModel {
  @override
  List<_i10.ProductModel> get products => (super.noSuchMethod(
        Invocation.getter(#products),
        returnValue: <_i10.ProductModel>[],
        returnValueForMissingStub: <_i10.ProductModel>[],
      ) as List<_i10.ProductModel>);

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
  _i2.Products toEntity() => (super.noSuchMethod(
        Invocation.method(
          #toEntity,
          [],
        ),
        returnValue: _FakeProducts_0(
          this,
          Invocation.method(
            #toEntity,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeProducts_0(
          this,
          Invocation.method(
            #toEntity,
            [],
          ),
        ),
      ) as _i2.Products);
}

/// A class which mocks [Products].
///
/// See the documentation for Mockito's code generation for more information.
class MockProducts extends _i1.Mock implements _i2.Products {
  @override
  List<_i11.ProductDetails> get productsDetails => (super.noSuchMethod(
        Invocation.getter(#productsDetails),
        returnValue: <_i11.ProductDetails>[],
        returnValueForMissingStub: <_i11.ProductDetails>[],
      ) as List<_i11.ProductDetails>);

  @override
  List<Object?> get props => (super.noSuchMethod(
        Invocation.getter(#props),
        returnValue: <Object?>[],
        returnValueForMissingStub: <Object?>[],
      ) as List<Object?>);
}
