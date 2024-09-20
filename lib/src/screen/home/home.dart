import 'package:appixoadmin/src/utils/Constants/colors.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            "assets/images/logo.png",
            height: 100,
            width: 100,
          ),
          backgroundColor: AppColors.primary,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 18,
                child: ClipOval(
                  child: Image.network(
                    'https://png.pngtree.com/png-vector/20230928/ourmid/pngtree-young-indian-man-png-image_10149659.png',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 5, right: 24),
              child: Text(
                "Manish sahu",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double height = constraints.maxHeight;

            return Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.15,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2, color: Colors.grey),
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/logo.png",
                              height: 100,
                              width: 100,
                            ),
                            // Check the screen width to determine button label visibility
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.home),
                              label: (width < 300)
                                  ? SizedBox.shrink()
                                  : Text("Home"), // Hide label on small screens
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.hovered)) {
                                      return Colors
                                          .green; // Change color when hovered
                                    }
                                    return Colors
                                        .blue; // Default background color
                                  },
                                ),
                                foregroundColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.hovered)) {
                                      return Colors
                                          .white; // Text/icon color when hovered
                                    }
                                    return Colors
                                        .white; // Default text/icon color
                                  },
                                ),
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: width * 0.04,
                                      vertical: height * 0.02),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Border radius
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: width * 0.85,
                        height: double.infinity,
                        color: Colors.red,
                        child: Column(
                          children: [
                            Container(
                              width: 200,
                              height: 100,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ));
  }
}
