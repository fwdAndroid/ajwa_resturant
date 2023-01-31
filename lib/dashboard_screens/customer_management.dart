import 'package:ajwa_resturant/add_forms/addCustomer.dart';
import 'package:ajwa_resturant/widgets/colors.dart';
import 'package:ajwa_resturant/widgets/input_text.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floating_action_bubble_custom/floating_action_bubble_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomerManagement extends StatefulWidget {
  const CustomerManagement({super.key});

  @override
  State<CustomerManagement> createState() => _CustomerManagementState();
}

class _CustomerManagementState extends State<CustomerManagement>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  TextEditingController _customerName = TextEditingController();
  TextEditingController _customerRoomNumber = TextEditingController();
  TextEditingController _customerPhoneNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _animationController,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,

      //Init Floating Action Bubble
      floatingActionButton: FloatingActionBubble(
        // animation controller
        animation: _animation,

        // On pressed change animation state
        onPressed: () => _animationController.isCompleted
            ? _animationController.reverse()
            : _animationController.forward(),

        // Floating Action button Icon color
        iconColor: Colors.white,

        // Floating Action button Icon
        iconData: Icons.add_task,
        backgroundColor: AppColors.primary,
        // Menu items
        items: <Widget>[
          // Floating action menu item

          //Floating action menu item
          BubbleMenu(
            title: "Add Customers",
            iconColor: Colors.white,
            bubbleColor: AppColors.primary,
            icon: Icons.restaurant,
            style: const TextStyle(fontSize: 16, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const AddCustomer(),
                ),
              );
              _animationController.reverse();
            },
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("customer").snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasError) {
              return AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    'No Items Yet  Added',
                    textStyle: const TextStyle(
                      fontSize: 22.0,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                totalRepeatCount: 4,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: LoadingAnimationWidget.hexagonDots(
                      color: AppColors.primary, size: 200));
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 270.0,
                    crossAxisSpacing: 55.0,
                    mainAxisSpacing: 55.0,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var snap = snapshot.data!.docs[index];

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Customer Name: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(snap['customerName']),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Customer Room: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(snap['customerRoomNumber']),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Customer Phone: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(snap['customerPhoneNumber']),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MaterialButton(
                                  color: Colors.green,
                                  elevation: 6,
                                  shape: StadiumBorder(),
                                  onPressed: () {
                                    showGeneralDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierLabel:
                                            MaterialLocalizations.of(context)
                                                .modalBarrierDismissLabel,
                                        barrierColor: Colors.black45,
                                        transitionDuration:
                                            const Duration(milliseconds: 200),
                                        pageBuilder: (BuildContext buildContext,
                                            Animation animation,
                                            Animation secondaryAnimation) {
                                          return Center(
                                            child: Material(
                                              child: Container(
                                                width: 500,
                                                height: 370,
                                                padding: EdgeInsets.all(20),
                                                color: Colors.white,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Center(
                                                          child:
                                                              AnimatedTextKit(
                                                        animatedTexts: [
                                                          WavyAnimatedText(
                                                            'Kindly Fill out all field to update the data',
                                                            textStyle:
                                                                const TextStyle(
                                                              fontSize: 15.0,
                                                              color: AppColors
                                                                  .primary,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                        totalRepeatCount: 4,
                                                        pause: const Duration(
                                                            milliseconds: 1000),
                                                        displayFullTextOnTap:
                                                            true,
                                                        stopPauseOnTap: true,
                                                      )),
                                                      const SizedBox(height: 9),
                                                      const Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Edit Customer Name",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                      InputText(
                                                        labelText: snap[
                                                            'customerName'],
                                                        controller:
                                                            _customerName,
                                                        keyboardType:
                                                            TextInputType
                                                                .visiblePassword,
                                                        onChanged: (value) {},
                                                        onSaved: (val) {},
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        isPassword: false,
                                                        enabled: true,
                                                      ),
                                                      const SizedBox(height: 9),
                                                      const Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Edit Customer Room",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                      InputText(
                                                        controller:
                                                            _customerRoomNumber,
                                                        labelText: snap[
                                                            'customerRoomNumber'],
                                                        keyboardType:
                                                            TextInputType
                                                                .visiblePassword,
                                                        onChanged: (value) {},
                                                        onSaved: (val) {},
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        isPassword: false,
                                                        enabled: true,
                                                      ),
                                                      const SizedBox(height: 9),
                                                      const Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Edit Customer Phone",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                      InputText(
                                                        controller:
                                                            _customerPhoneNumber,
                                                        labelText: snap[
                                                            'customerPhoneNumber'],
                                                        keyboardType:
                                                            TextInputType
                                                                .visiblePassword,
                                                        onChanged: (value) {},
                                                        onSaved: (val) {},
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        isPassword: false,
                                                        enabled: true,
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "customer")
                                                              .doc(snap['uuid'])
                                                              .update({
                                                            "customerName":
                                                                _customerName
                                                                    .text,
                                                            "customerPhoneNumber":
                                                                _customerPhoneNumber
                                                                    .text,
                                                            "customerRoomNumber":
                                                                _customerRoomNumber
                                                                    .text
                                                          });
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  SnackBar(
                                                            backgroundColor:
                                                                Colors.blue,
                                                            duration: Duration(
                                                                seconds: 5),
                                                            content: Text(
                                                              "Customer Details is updated successfully",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ));
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          "Save",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .primary,
                                                                shape:
                                                                    StadiumBorder(),
                                                                fixedSize: Size(
                                                                    300, 40)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Text(
                                    "Update",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    showGeneralDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierLabel:
                                            MaterialLocalizations.of(context)
                                                .modalBarrierDismissLabel,
                                        barrierColor: Colors.black45,
                                        transitionDuration:
                                            const Duration(milliseconds: 200),
                                        pageBuilder: (BuildContext buildContext,
                                            Animation animation,
                                            Animation secondaryAnimation) {
                                          return Center(
                                            child: Material(
                                              child: Container(
                                                width: 300,
                                                height: 200,
                                                padding: EdgeInsets.all(20),
                                                color: Colors.white,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Center(
                                                          child:
                                                              AnimatedTextKit(
                                                        animatedTexts: [
                                                          WavyAnimatedText(
                                                            'Are you sure to delete your Customer',
                                                            textStyle:
                                                                const TextStyle(
                                                              fontSize: 15.0,
                                                              color: AppColors
                                                                  .primary,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                        totalRepeatCount: 4,
                                                        pause: const Duration(
                                                            milliseconds: 1000),
                                                        displayFullTextOnTap:
                                                            true,
                                                        stopPauseOnTap: true,
                                                      )),
                                                      const SizedBox(height: 9),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "customer")
                                                              .doc(snap['uuid'])
                                                              .delete();
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  SnackBar(
                                                            backgroundColor:
                                                                Colors.blue,
                                                            duration: Duration(
                                                                seconds: 5),
                                                            content: Text(
                                                              "Customer is deleted successfully",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ));
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          "Delete",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .primary,
                                                                shape:
                                                                    StadiumBorder(),
                                                                fixedSize: Size(
                                                                    300, 40)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  color: Colors.red,
                                  elevation: 6,
                                  shape: StadiumBorder(),
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }),
    );
  }
}
