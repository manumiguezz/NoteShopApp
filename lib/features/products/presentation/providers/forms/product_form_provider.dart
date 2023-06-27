

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/products_provider.dart';

import '../../../../shared/shared.dart';


final productFormProvider = StateNotifierProvider.autoDispose.family<ProductFormNotifier, ProductFormState, Product>
  ((ref, product) {

    final createUpdateCallback = ref.watch(productsProvider.notifier).createOrUpdateProduct;

    return ProductFormNotifier(
      product: product,
      onSubmitCallBack: createUpdateCallback
    );
  });



class ProductFormNotifier extends StateNotifier<ProductFormState> {

  final Future<bool> Function (Map<String, dynamic> productLike)? onSubmitCallBack;

  ProductFormNotifier({
    this.onSubmitCallBack,
    required Product product,
  }): super(
    ProductFormState(
      id: product.id,
      title: Title.dirty(product.title),
      slug: Slug.dirty(product.slug),
      price: Price.dirty(product.price),
      inStock: Stock.dirty(product.stock),
      size: product.sizes,
      gender: product.gender,
      description: product.description,
      tags: product.tags.join(', '),
      images: product.images, 
    )
  );

  Future<bool> onFormSubmit() async {
    _touchedEverything();

    if(!state.isFormValid) return false;
    if(onSubmitCallBack == null) return false;

    final productLike = {
      'id': (state.id == 'new') ? null : state.id,
      'title': state.title.value,
      'price': state.price.value,
      'description': state.description,
      'slug': state.slug.value,
      'stock': state.inStock.value,
      'sizes': state.size,
      'gender': state.gender,
      'tags': state.tags.split(','),
      'images': state.images.map((image) => image.replaceAll('${Environment.apiUrl}/files/product/', '')
      ).toList()
    };

    try {
    return await onSubmitCallBack!(productLike);

    } catch (e) {
      return false;
    }
  }

  void _touchedEverything() {
    state = state.copyWith(
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ])
    );
  }

  void updateProductImage(String path) {
    state = state.copyWith(
      images: [...state.images, path]
    );
  }


  void onTitleChanged(String value) {
    state = state.copyWith(
      title: Title.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ])
    );
  }

  void onSlugChanged(String value) {
    state = state.copyWith(
      slug: Slug.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ])
    );
  }

  void onPriceChanged(double value) {
    state = state.copyWith(
      price: Price.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(value),
        Stock.dirty(state.inStock.value),
      ])
    );
  }

  void onStockChanged(int value) {
    state = state.copyWith(
      inStock: Stock.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(value),
      ])
    );
  }

  void onSizedChanged(List<String> sizes) {
    state = state.copyWith(
      size: sizes
    );
  }

  void onGenderChanged(String gender) {
    state = state.copyWith(
      gender: gender
    );
  }

  void onDescriptionChanged(String description) {
    state = state.copyWith(
      description: description
    );
  }  

  void onTagsChanged(String tags) {
    state = state.copyWith(
      tags: tags
    );
  }

}


class ProductFormState {

  final bool isFormValid;
  final String? id;
  final Title title;
  final Slug slug;
  final Price price;
  final List<String> size;
  final String gender;
  final Stock inStock;
  final String description;
  final String tags;
  final List<String> images;

  ProductFormState({
    this.isFormValid = false, 
    this.id, 
    this.title = const Title.dirty(''), 
    this.slug = const Slug.dirty(''), 
    this.price = const Price.dirty(0), 
    this.size = const [], 
    this.gender = 'men', 
    this.inStock = const Stock.dirty(0), 
    this.description = '', 
    this.tags = '', 
    this.images = const []
  });

  ProductFormState copyWith({
    bool? isFormValid,
    String? id,
    Title? title,
    Slug? slug,
    Price? price,
    List<String>? size,
    String? gender,
    Stock? inStock,
    String? description,
    String? tags,
    List<String>? images,
  }) => ProductFormState(
    isFormValid: isFormValid ?? this.isFormValid,
    id: id ?? this.id,
    title: title ?? this.title,
    slug: slug ?? this.slug,
    price: price ?? this.price,
    size: size ?? this.size,
    gender: gender ?? this.gender,
    inStock: inStock ?? this.inStock,
    description: description ?? this.description,
    tags: tags ?? this.tags,
    images: images ?? this.images,
  );
}