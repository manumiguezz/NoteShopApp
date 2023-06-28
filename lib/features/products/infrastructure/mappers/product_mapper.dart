

import 'package:noteshop/config/config.dart';
import 'package:noteshop/features/auth/infrastructure/mappers/user_mapper.dart';
import 'package:noteshop/features/products/domain/entities/product.dart';

class ProductMapper {

  static jsonToEntity( Map<String, dynamic> json ) => Product(
    id: json['id'], 
    title: json['title'], 
    price: double.parse(json['price'].toString()), 
    description: json['description'], 
    slug: json['slug'], 
    stock: json['stock'], 
    sizes: List<String>.from(json['sizes'].map( (size) => size)), 
    gender: json['gender'], 
    tags: List<String>.from(json['tags'].map( (tag) => tag)), 
    images: List<String>.from(
      json['images'].map( (image) => image.startsWith('http')
      ? image
      : '${Environment.apiUrl}/files/product/$image'
    )), 
    user: UserMapper.userJsonToEntity(json['user']), 
  );
}