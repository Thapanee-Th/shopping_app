import 'package:get/get.dart';
import 'package:shopping_app/src/app/home/services/home_service.dart';
import 'package:shopping_app/src/model/item.dart';
import 'package:shopping_app/src/model/product.dart';

class HomeController extends GetxController {
  Rx<Product> product = Product().obs;
  RxList<Item> items = <Item>[].obs;
  RxList<Item> carts = <Item>[].obs;
  Rx<double> subtotal = 0.0.obs;

  var isLoading = true.obs;
  final int productLimit = 20;
  RxList<int> cartList = <int>[].obs;

  final ProductsService productsService = ProductsService();

  void fetchProducts() async {
    try {
      isLoading(true);
      final fetchedProduct = await productsService.fetchProducts();
      await Future.delayed(const Duration(seconds: 5));
      product.value = fetchedProduct;
      final fetchedCart = await productsService.fetchRecommendedProducts();
      await Future.delayed(const Duration(seconds: 5));
      items.assignAll(fetchedCart);
    } finally {
      isLoading(false);
    }
  }

  void refreshData() {
    fetchProducts();
  }

  addTocard(Item item) {
    carts = <Item>[].obs;
    subtotal = 0.0.obs;
    if (product.value.items != null) {
      var productCarttmp = product.value.items!
          .where((element) => element.quantity! > 0)
          .toList();
      carts.addAll(productCarttmp);
    }
    if (items.isNotEmpty) {
      var productCarttmp =
          items.where((element) => element.quantity! > 0).toList();
      carts.addAll(productCarttmp);
    }
    List<Item> c = carts;

    for (var e in c) {
      subtotal += (e.price ?? 0) * (e.quantity ?? 0);
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }
}
