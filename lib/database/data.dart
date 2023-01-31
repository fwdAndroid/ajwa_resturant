import 'package:ajwa_resturant/models/customer_model.dart';
import 'package:ajwa_resturant/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class DatabaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<String> addCustomer({
    required String customerName,
    required String customerPhone,
    required String customerRoom,
    required String uuid,
  }) async {
    String res = 'Some error occured';

    try {
      if (customerName.isNotEmpty || customerRoom.isNotEmpty) {
        //Add User to the database with modal
        var uuid = Uuid().v1();
        Customer_Model userModel = Customer_Model(
          customerName: customerName,
          customerPhoneNumber: customerPhone,
          customerRoomNumber: customerRoom,
          uuid: uuid,
        );
        await firebaseFirestore
            .collection('customer')
            .doc(uuid)
            .set(userModel.toJson());

        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Add Orders
  Future<String> addOrders({
    required String customerName,
    required String customerMenuDetail,
    required String customerRoom,
    required String totalPrice,
    required String uuid,
  }) async {
    String res = 'Some error occured';

    try {
      if (customerName.isNotEmpty || customerRoom.isNotEmpty) {
        //Add User to the database with modal
        var uuid = Uuid().v1();
        Order_Model userModel = Order_Model(
            customerName: customerName,
            customerMenuDetail: customerMenuDetail,
            customerRoomNumber: customerRoom,
            uuid: uuid,
            totalPrice: totalPrice);
        await firebaseFirestore
            .collection('orders')
            .doc(uuid)
            .set(userModel.toJson());

        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
