import 'package:ajwa_resturant/database/data.dart';
import 'package:ajwa_resturant/widgets/colors.dart';
import 'package:ajwa_resturant/widgets/exc_button.dart';
import 'package:ajwa_resturant/widgets/input_text.dart';
import 'package:ajwa_resturant/widgets/sidebar.dart';
import 'package:ajwa_resturant/widgets/utils.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:email_validator/email_validator.dart';
import 'package:uuid/uuid.dart';

class AddFoodOrders extends StatefulWidget {
  const AddFoodOrders({super.key});

  @override
  State<AddFoodOrders> createState() => _AddFoodOrdersState();
}

class _AddFoodOrdersState extends State<AddFoodOrders> {
  TextEditingController _customerName = TextEditingController();
  TextEditingController _customerRoomNumber = TextEditingController();
  TextEditingController _customerMenuDetail = TextEditingController();
  TextEditingController _customerMenuPrice = TextEditingController();

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "Go Back",
          textAlign: TextAlign.center,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                width: 448,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText(
                          'Add Customers Order',
                          textStyle: const TextStyle(
                            fontSize: 25.0,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      totalRepeatCount: 4,
                      pause: const Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                    const SizedBox(height: 21),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Customer Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 9),
                    InputText(
                      controller: _customerName,
                      labelText: "Fawad Kaleem",
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {},
                      onSaved: (val) {},
                      textInputAction: TextInputAction.done,
                      isPassword: false,
                      enabled: true,
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Customer Room Number",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 9),
                    InputText(
                      controller: _customerRoomNumber,
                      labelText: "23",
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {},
                      onSaved: (val) {},
                      textInputAction: TextInputAction.done,
                      isPassword: false,
                      enabled: true,
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Customer Menu Detail",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 9),
                    InputText(
                      controller: _customerMenuDetail,
                      labelText: "Burger Fries etc",
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {},
                      onSaved: (val) {},
                      textInputAction: TextInputAction.done,
                      isPassword: false,
                      enabled: true,
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Customer Menu Price",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 9),
                    InputText(
                      controller: _customerMenuPrice,
                      labelText: "40",
                      keyboardType: TextInputType.number,
                      onChanged: (value) {},
                      onSaved: (val) {},
                      textInputAction: TextInputAction.done,
                      isPassword: false,
                      enabled: true,
                    ),
                    const SizedBox(height: 40),
                    WonsButton(
                      height: 50,
                      width: 348,
                      verticalPadding: 0,
                      color: AppColors.primary,
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                          : Text(
                              "Add",
                              style: TextStyle(
                                  color: AppColors.neutral,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                      onPressed: onCreate,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onCreate() async {
    setState(() {
      _isLoading = true;
    });
    var uuid = Uuid().v1();
    String rse = await DatabaseMethods().addOrders(
      customerName: _customerName.text,
      customerMenuDetail: _customerMenuDetail.text,
      totalPrice: _customerMenuPrice.text,
      customerRoom: _customerName.text,
      uuid: uuid,
    );

    print(rse);
    setState(() {
      _isLoading = false;
    });
    if (rse != 'sucess') {
      Customdialog().showInSnackBar("Success", context);
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => SideDrawer()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Conguration Data is Added")));
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => SideDrawer()));
    }
  }
}
