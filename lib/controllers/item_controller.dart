import 'package:food_delivery_app/models/cart_item.dart';
import 'package:food_delivery_app/models/food_category.dart';
import 'package:food_delivery_app/models/item.dart';
import 'package:food_delivery_app/services/item_service.dart';
import 'package:get/get.dart';

/// For the STATE of food items.
class ItemController extends GetxController {

  final _selectedCategory = Rxn<FoodCategory>();
  FoodCategory? get selectedCategory => _selectedCategory.value;
  set setCategory(FoodCategory? category) => _selectedCategory(category);

  final _loadingItems = false.obs;
  bool get isLoadingItems => _loadingItems.value;
  final _items = Rxn<List<Item>>();
  List<Item> get items => _items.value??[];
  Item? itemById(String itemId){
    return items.firstWhereOrNull((e) => e.id==itemId);
  }

  final _loadingFavItems = false.obs;
  bool get isLoadingFavItems => _loadingFavItems.value;
  final _favItems = Rxn<List<Item>>();
  List<Item> get favItems => _favItems.value??[];

  final _loadingCartItems = false.obs;
  bool get isLoadingCartItems => _loadingCartItems.value;
  final _cartItems = Rxn<List<CartItem>>();
  List<CartItem> get cartItems => _cartItems.value??[];
  double get cartTotalPrice =>cartItems.fold(
    0, (prev, e) => prev+ (e.item?.price??0)*(e.quantity??1)
  );

  final _loadingSigleItem = {}.obs;
  bool loadingSingleItem(String itemId){
    return _loadingSigleItem[itemId]==true;
  }

  @override
  void onInit() {
    // fetchFoodItems(); //Fetch products on initialize
    super.onInit();
  }

  Future fetchItems({bool enableLoading = true}) async {
    if(enableLoading){
      _loadingItems(true);
    }
    // await Future.delayed(Duration(milliseconds: 2000));
    final items = await ItemService.getItems();
    _items(items);
    // _items(_sampleItems+_sampleItems+_sampleItems);

    if(enableLoading){
      _loadingItems(false);
    }
  }

  Future fetchFavItems({required List<String> favItemIds, bool enableLoading = true}) async {
    if(enableLoading){
      _loadingFavItems(true);
    }
    final res = await ItemService.getSpecificItems(favItemIds);
    _favItems(res);
    if(enableLoading){
      _loadingFavItems(false);
    }
  }

  Future fetchCartItems({required List<CartItem> cart, bool enableLoading = true}) async {
    if(enableLoading){
      _loadingCartItems(true);
    }
    final res = await ItemService.getSpecificItems(
      cart.map((e) => e.itemId).toList()
    );
    if(res!=null){
      for(int i=0;i<cart.length;i++){
        final item  = res.firstWhereOrNull((e) => e.id==cart[i].itemId);
        cart[i].item=item;
      }
    }
    _cartItems(cart);
    if(enableLoading){
      _loadingCartItems(false);
    }
  }

  
}

List<Item> _sampleItems = [
  Item(
    id: "1",
    name: "Burger",
    category: ["Snack"],
    descEnglish: "High quality beef medium to well with cheese and bacon on a multigrain bun.",
    descHindi: "मल्टीग्रेन बन पर पनीर और बेकन के साथ उच्च गुणवत्ता वाले बीफ़ मध्यम से अच्छी तरह से।",
    images: [
      "https://img.freepik.com/free-photo/double-hamburger-isolated-white-background-fresh-burger-fast-food-with-beef-cream-cheese_90220-1192.jpg",
      "https://www.licious.in/blog/wp-content/uploads/2022/08/shutterstock_2014376390.jpg"
    ],
    price: 80,
    reviews: [
      
    ]
  ),
  Item(
    id: "1",
    name: "Burger",
    category: ["Snack"],
    descEnglish: "High quality beef medium to well with cheese and bacon on a multigrain bun.",
    descHindi: "मल्टीग्रेन बन पर पनीर और बेकन के साथ उच्च गुणवत्ता वाले बीफ़ मध्यम से अच्छी तरह से।",
    images: [
      "https://img.freepik.com/free-photo/double-hamburger-isolated-white-background-fresh-burger-fast-food-with-beef-cream-cheese_90220-1192.jpg",
      "https://www.licious.in/blog/wp-content/uploads/2022/08/shutterstock_2014376390.jpg"
    ],
    price: 80,
    reviews: [
      
    ]
  ),
  Item(
    id: "1",
    name: "Burger",
    category: ["Snack"],
    descEnglish: "High quality beef medium to well with cheese and bacon on a multigrain bun.",
    descHindi: "मल्टीग्रेन बन पर पनीर और बेकन के साथ उच्च गुणवत्ता वाले बीफ़ मध्यम से अच्छी तरह से।",
    images: [
      "https://img.freepik.com/free-photo/double-hamburger-isolated-white-background-fresh-burger-fast-food-with-beef-cream-cheese_90220-1192.jpg",
      "https://www.licious.in/blog/wp-content/uploads/2022/08/shutterstock_2014376390.jpg"
    ],
    price: 80,
    reviews: [
      
    ]
  ),
  Item(
    id: "1",
    name: "Burger",
    category: ["Snack"],
    descEnglish: "High quality beef medium to well with cheese and bacon on a multigrain bun.",
    descHindi: "मल्टीग्रेन बन पर पनीर और बेकन के साथ उच्च गुणवत्ता वाले बीफ़ मध्यम से अच्छी तरह से।",
    images: [
      "https://img.freepik.com/free-photo/double-hamburger-isolated-white-background-fresh-burger-fast-food-with-beef-cream-cheese_90220-1192.jpg",
      "https://www.licious.in/blog/wp-content/uploads/2022/08/shutterstock_2014376390.jpg"
    ],
    price: 80,
    reviews: [
      
    ]
  )
];