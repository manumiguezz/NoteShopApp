


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noteshop/features/auth/presentation/providers/auth_provider.dart';
import 'package:noteshop/features/products/domain/domain.dart';
import 'package:noteshop/features/products/infrastructure/datasources/products_datasource_impl.dart';
import 'package:noteshop/features/products/infrastructure/repositories/products_repository_impl.dart';

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {

  final accessToken = ref.watch(authProvider).user?.token ?? '';
  
  final productsRepository = ProductsRepositoryImpl(
    ProductsDatasourceImpl(accessToken: accessToken)
  );

  return productsRepository; 
});