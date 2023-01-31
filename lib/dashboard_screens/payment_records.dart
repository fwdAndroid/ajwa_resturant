import 'package:ajwa_resturant/widgets/colors.dart';
import 'package:ajwa_resturant/widgets/input_text.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PaymentRecords extends StatefulWidget {
  const PaymentRecords({super.key});

  @override
  State<PaymentRecords> createState() => _PaymentRecordsState();
}

class _PaymentRecordsState extends State<PaymentRecords> {
  TextEditingController hotl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("orders").snapshots(),
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
                    maxCrossAxisExtent: 250.0,
                    crossAxisSpacing: 35.0,
                    mainAxisSpacing: 35.0,
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Customer Name',
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Customer Menu Detail: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(snap['customerMenuDetail']),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Hotel Name: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(snap['OrderAssignHotelName']),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Hotel Payment: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(snap['HotelPrice']),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextButton(
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
                                              height: 280,
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
                                                        child: AnimatedTextKit(
                                                      animatedTexts: [
                                                        WavyAnimatedText(
                                                          'Kindly Fill out all field to update the data',
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 15.0,
                                                            color: AppColors
                                                                .primary,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "Enter Hotel Price",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    InputText(
                                                      labelText:
                                                          "Enter Hotel Price",
                                                      controller: hotl,
                                                      keyboardType:
                                                          TextInputType
                                                              .visiblePassword,
                                                      onChanged: (value) {},
                                                      onSaved: (val) {},
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      isPassword: false,
                                                      enabled: true,
                                                    ),
                                                    const SizedBox(height: 9),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "orders")
                                                            .doc(snap['uuid'])
                                                            .update({
                                                          "HotelPrice":
                                                              hotl.text,
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
                                                            "Payment Add Successfully is updated successfully",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ));
                                                        Navigator.pop(context);
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
                                child: Text("Add Hotel Price")),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }),
    );
    ;
  }
}
