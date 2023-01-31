import 'package:cloud_firestore/cloud_firestore.dart';

class Customer_Model {
  String uuid;
  String customerName;
  String customerRoomNumber;
  String customerPhoneNumber;

  Customer_Model({
    required this.uuid,
    required this.customerName,
    required this.customerPhoneNumber,
    required this.customerRoomNumber,
  });

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'customerPhoneNumber': customerPhoneNumber,
        'uuid': uuid,
        'customerRoomNumber': customerRoomNumber,
        'customerName': customerName,
      };

  ///
  static Customer_Model fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return Customer_Model(
      customerPhoneNumber: snapshot['customerPhoneNumber'],
      customerName: snapshot['customerName'],
      customerRoomNumber: snapshot['customerRoomNumber'],
      uuid: snapshot['uuid'],
    );
  }
}
