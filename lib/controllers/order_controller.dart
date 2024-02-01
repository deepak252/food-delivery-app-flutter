import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/models/order.dart';
import 'package:food_delivery_app/services/order_service.dart';
import 'package:food_delivery_app/utils/logger.dart';
import 'package:get/get.dart';

class OrderController extends GetxController{
  final _logger = Logger("OrderController");

  final _loading = false.obs;
  bool get isLoading => _loading.value;

  final _loadingOrders = false.obs;
  bool get isLoadingOrders => _loadingOrders.value;
  final _orders = Rxn<List<Order>>();
  List<Order> get orders => _orders.value??[];
  

  final _loadingSigleOrder = {}.obs;
  bool loadingSingleOrder(String orderId){
    return _loadingSigleOrder[orderId]==true;
  }

  final _userController = Get.put(UserController());

  @override
  void onInit() {
    super.onInit();
  }

  Future createOrder({required Order order ,bool enableLoading = false})async{
    if(enableLoading){
      _loading(true);
    }
    
    final orderCreated = await OrderService.createOrder(order);
    if(orderCreated){
      _logger.message("createOrder", "Order Created Successfully");
    }

    if(enableLoading){
      _loading(false);
    }
  }

  Future fetchOrders({ bool enableLoading = false})async{
    if(!_userController.isSignedIn){
      _logger.error("fetchOrders",error : "Not Signed In");
      return;
    }
    if(enableLoading){
      _loadingOrders(true);
    }
    
    final res  = await OrderService.getOrders(_userController.user?.id??'');
    if(res!=null){
      _orders.update((val) {
        _orders(res);
      });
    }
    // _user(_usr);
    if(enableLoading){
      _loadingOrders(false);
    }
  }
}