import 'package:food_delivery_app/models/item.dart';
import 'package:food_delivery_app/services/item_service.dart';
import 'package:get/get.dart';

/// For the STATE of food items.
class ItemController extends GetxController {

  final _loadingItems = false.obs;
  bool get isLoadingItems => _loadingItems.value;
  final _items = Rxn<List<Item>>();
  List<Item> get items => _items.value??[];
  Item? itemById(String itemId){
    return items.firstWhereOrNull((e) => e.id==itemId);
  }

  final _loadingSigleItem = {}.obs;
  bool loadingSingleItem(String itemId){
    return _loadingSigleItem[itemId]==true;
  }

  @override
  void onInit() {
    // fetchFoodItems(); //Fetch products on initialize
    super.onInit();
  }

  Future fetchFoodItems({bool enableLoading = true}) async {
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