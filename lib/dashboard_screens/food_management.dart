import 'package:ajwa_resturant/widgets/colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floating_action_bubble_custom/floating_action_bubble_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FoodManagement extends StatefulWidget {
  const FoodManagement({super.key});

  @override
  State<FoodManagement> createState() => _FoodManagementState();
}

class _FoodManagementState extends State<FoodManagement>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _areaContoller = TextEditingController();

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
            title: "Add Food Menus",
            iconColor: Colors.white,
            bubbleColor: AppColors.primary,
            icon: Icons.restaurant,
            style: const TextStyle(fontSize: 16, color: Colors.white),
            onPressed: () {},
            // onPressed: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (BuildContext context) => const AddFoodMenu(),
            //     ),
            //   );
            //   _animationController.reverse();
            // },
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("foods").snapshots(),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'foodCategory: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(snap['foodCategory']),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Food Name: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(snap['foodName']),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Menu: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(snap['menu']),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Price:',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(snap['price']),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
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
