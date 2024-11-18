import 'package:shopping_app/apis/helper_api.dart';
import 'package:shopping_app/src/model/item.dart';
import 'package:shopping_app/src/model/product.dart';

class ProductsService {
  Future<Product> fetchProducts() async {
    try {
      final response = await HelperApi.httpGet(path: '/products?limit=20');
      return Product.fromJson(response);
    } catch (e) {
      throw Exception('Error fetching product: $e');
    }
  }

  Future<List<Item>> fetchRecommendedProducts() async {
    try {
      final response = await HelperApi.httpGet(path: '/recommended-products');
      final data = response;

      return List.generate(data.length, (index) => Item.fromJson(data[index]));
    } catch (e) {
      return [];
    }
  }

  Future<List<Item>> fetchOrderCheckout() async {
    try {
      final response =
          await HelperApi.httpPost(path: '/orders/checkout', body: {});

      final data = response;

      return List.generate(data.length, (index) => Item.fromJson(data[index]));
    } catch (e) {
      throw Exception('Error fetching product: $e');
    }
  }
}
