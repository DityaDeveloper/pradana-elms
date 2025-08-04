// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categoryListHash() => r'45b37e25b62c2c01d4c4a1de149c36933ff9a042';

/// See also [CategoryList].
@ProviderFor(CategoryList)
final categoryListProvider = AutoDisposeAsyncNotifierProvider<CategoryList,
    List<CategoryModel>?>.internal(
  CategoryList.new,
  name: r'categoryListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$categoryListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CategoryList = AutoDisposeAsyncNotifier<List<CategoryModel>?>;
String _$productListHash() => r'91f529f649f9622aa3019068b034289fea82cf1b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ProductList
    extends BuildlessAutoDisposeAsyncNotifier<List<ProductModel>?> {
  late final int categoryId;

  FutureOr<List<ProductModel>?> build({
    required int categoryId,
  });
}

/// See also [ProductList].
@ProviderFor(ProductList)
const productListProvider = ProductListFamily();

/// See also [ProductList].
class ProductListFamily extends Family<AsyncValue<List<ProductModel>?>> {
  /// See also [ProductList].
  const ProductListFamily();

  /// See also [ProductList].
  ProductListProvider call({
    required int categoryId,
  }) {
    return ProductListProvider(
      categoryId: categoryId,
    );
  }

  @override
  ProductListProvider getProviderOverride(
    covariant ProductListProvider provider,
  ) {
    return call(
      categoryId: provider.categoryId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productListProvider';
}

/// See also [ProductList].
class ProductListProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ProductList, List<ProductModel>?> {
  /// See also [ProductList].
  ProductListProvider({
    required int categoryId,
  }) : this._internal(
          () => ProductList()..categoryId = categoryId,
          from: productListProvider,
          name: r'productListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productListHash,
          dependencies: ProductListFamily._dependencies,
          allTransitiveDependencies:
              ProductListFamily._allTransitiveDependencies,
          categoryId: categoryId,
        );

  ProductListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final int categoryId;

  @override
  FutureOr<List<ProductModel>?> runNotifierBuild(
    covariant ProductList notifier,
  ) {
    return notifier.build(
      categoryId: categoryId,
    );
  }

  @override
  Override overrideWith(ProductList Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductListProvider._internal(
        () => create()..categoryId = categoryId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProductList, List<ProductModel>?>
      createElement() {
    return _ProductListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductListProvider && other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductListRef
    on AutoDisposeAsyncNotifierProviderRef<List<ProductModel>?> {
  /// The parameter `categoryId` of this provider.
  int get categoryId;
}

class _ProductListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProductList,
        List<ProductModel>?> with ProductListRef {
  _ProductListProviderElement(super.provider);

  @override
  int get categoryId => (origin as ProductListProvider).categoryId;
}

String _$orderStoreHash() => r'6602a99a9e7768a48dacb96fe799fbe44097f0f1';

/// See also [OrderStore].
@ProviderFor(OrderStore)
final orderStoreProvider =
    AutoDisposeNotifierProvider<OrderStore, bool>.internal(
  OrderStore.new,
  name: r'orderStoreProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$orderStoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OrderStore = AutoDisposeNotifier<bool>;
String _$orderHistoryListHash() => r'a9caf27b4463476ecc166157fce3f344dc224bfd';

/// See also [OrderHistoryList].
@ProviderFor(OrderHistoryList)
final orderHistoryListProvider = AutoDisposeAsyncNotifierProvider<
    OrderHistoryList, List<OrderModel>>.internal(
  OrderHistoryList.new,
  name: r'orderHistoryListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orderHistoryListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OrderHistoryList = AutoDisposeAsyncNotifier<List<OrderModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
