import 'package:appixoadmin/src/components/custome_icon_button.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Define a variable to keep track of the selected screen
  String selectedScreen = "Dashboard";

  // Method to display the selected screen widget
  Widget _buildContent() {
    switch (selectedScreen) {
      case "Dashboard":
        return Container(
          width: 200,
          height: 100,
          color: Colors.white,
          child: Center(child: Text('Dashboard Content')),
        );
      case "Users":
        return Container(
          width: 200,
          height: 100,
          color: Colors.blue,
          child: Center(child: Text('Users Content')),
        );
      case "Rooms":
        return Container(
          width: 200,
          height: 100,
          color: Colors.green,
          child: Center(child: Text('Rooms Content')),
        );
      case "Foods":
        return Container(
          width: 200,
          height: 100,
          color: Colors.green,
          child: Center(child: Text('Foods Content')),
        );
      case "Deals":
        return Container(
          width: 200,
          height: 100,
          color: Colors.green,
          child: Center(child: Text('Deals Content')),
        );
      case "Reports":
        return Container(
          width: 200,
          height: 100,
          color: Colors.green,
          child: Center(child: Text('Reports Content')),
        );
      default:
        return Container(
          width: 200,
          height: 100,
          color: Colors.white,
          child: Center(child: Text('Dashboard Content')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;

        return Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    width: width * 0.15,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 2, color: Colors.grey.shade50),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/logo.png",
                          height: 100,
                          width: 150,
                          alignment: Alignment.topCenter,
                        ),

                        Text(
                          "Menu",
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Home Button
                        CustomButton(
                          title: "Dashboard",
                          icon: Icons.home,
                          onPress: () {
                            setState(() {
                              selectedScreen = "Dashboard";
                            });
                          },
                          isSelectedScreen: selectedScreen == 'Dashboard',
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        CustomButton(
                          title: "Users",
                          icon: Icons.group,
                          onPress: () {
                            setState(() {
                              selectedScreen = "Users";
                            });
                          },
                          isSelectedScreen: selectedScreen == 'Users',
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        CustomButton(
                          title: "Rooms",
                          icon: Icons.home_work,
                          onPress: () {
                            setState(() {
                              selectedScreen = "Rooms";
                            });
                          },
                          isSelectedScreen: selectedScreen == 'Rooms',
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        CustomButton(
                          title: "Foods",
                          icon: Icons.food_bank_outlined,
                          onPress: () {
                            setState(() {
                              selectedScreen = "Foods";
                            });
                          },
                          isSelectedScreen: selectedScreen == 'Foods',
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        CustomButton(
                          title: "Deals",
                          icon: Icons.handshake,
                          onPress: () {
                            setState(() {
                              selectedScreen = "Deals";
                            });
                          },
                          isSelectedScreen: selectedScreen == 'Deals',
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        CustomButton(
                          title: "Reports",
                          icon: Icons.report,
                          onPress: () {
                            setState(() {
                              selectedScreen = "Reports";
                            });
                          },
                          isSelectedScreen: selectedScreen == 'Reports',
                        ),
                      ],
                    ),
                  ),
                  // Main Container displaying content based on selected screen
                  Container(
                    width: width * 0.85,
                    height: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
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
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 5, right: 24),
                                child: Text(
                                  "Manish Sahu",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildContent(),
                        // Display the selected screen's content here
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
