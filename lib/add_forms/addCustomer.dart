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

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  TextEditingController _customerName = TextEditingController();
  TextEditingController _customerRoomNumber = TextEditingController();
  TextEditingController _customerPhoneNumber = TextEditingController();
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
                          'Add Customers in Ajwa Resturant Platform',
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
                        "Customer Phone Number",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 9),
                    InputText(
                      controller: _customerPhoneNumber,
                      labelText: "+82345234324",
                      keyboardType: TextInputType.visiblePassword,
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
    String rse = await DatabaseMethods().addCustomer(
      customerName: _customerName.text,
      customerPhone: _customerPhoneNumber.text,
      customerRoom: _customerName.text,
      uuid: uuid,
    );

    print(rse);
    setState(() {
      _isLoading = false;
    });
    if (rse != 'sucess') {
      Customdialog().showInSnackBar("Error", context);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Conguration Data is Added")));
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => SideDrawer()));
    }
  }
}
