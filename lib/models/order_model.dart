import 'package:cloud_firestore/cloud_firestore.dart';

class Order_Model {
  String uuid;
  String customerName;
  String customerRoomNumber;
  String customerMenuDetail;
  String totalPrice;
  String? OrderAssignHotelName;
  String? HotelPrice;

  Order_Model({
    this.OrderAssignHotelName,
    required this.uuid,
    this.HotelPrice,
    required this.customerName,
    required this.totalPrice,
    required this.customerRoomNumber,
    required this.customerMenuDetail,
  });

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'HotelPrice': HotelPrice,
        'OrderAssignHotelName': OrderAssignHotelName,
        'customerMenuDetail': customerMenuDetail,
        'uuid': uuid,
        'customerRoomNumber': customerRoomNumber,
        'customerName': customerName,
        'totalPrice': totalPrice,
      };

  ///
  static Order_Model fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return Order_Model(
        HotelPrice: snapshot['HotelPrice'],
        OrderAssignHotelName: snapshot['OrderAssignHotelName'],
        totalPrice: snapshot['totalPrice'],
        customerName: snapshot['customerName'],
        customerRoomNumber: snapshot['customerRoomNumber'],
        uuid: snapshot['uuid'],
        customerMenuDetail: snapshot['customerMenuDetail']);
  }
}
