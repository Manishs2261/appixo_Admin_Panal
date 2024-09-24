import 'package:appixoadmin/src/components/custome_icon_button.dart';
import 'package:appixoadmin/src/data/repository/api.dart';
import 'package:appixoadmin/src/screen/home/widgets/dashboard_screen.dart';
import 'package:appixoadmin/src/screen/home/widgets/desls_screen.dart';
import 'package:appixoadmin/src/screen/home/widgets/foods_screen.dart';
import 'package:appixoadmin/src/screen/home/widgets/reports_screen.dart';
import 'package:appixoadmin/src/screen/home/widgets/rooms_screen.dart';
import 'package:appixoadmin/src/screen/home/widgets/users_screen.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Define a variable to keep track of the selected screen
  String selectedScreen = "Rooms";

  // Method to display the selected screen widget
  Widget _buildContent() {
    switch (selectedScreen) {
      case "Dashboard":
        return DashboardScreen();
      case "Users":
        return UsersScreen();
      case "Rooms":
        return RoomsScreen();
      case "Foods":
        return FoodsScreen();
      case "Deals":
        return  DealsScreen();
      case "Reports":
        return ReportsScreen();
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
    ApiClass.getUserCount();
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
                      border: Border.all(color: Colors.grey.withOpacity(0.4)),
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
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.4)),
                              color: Colors.white),
                          child:   Row(
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
                                padding: const EdgeInsets.only(top: 8, bottom: 5, right: 8),
                                child: Text(
                                  "Manish Sahu",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              StatefulBuilder(
                                builder: (BuildContext context, StateSetter setState) {
                                  bool isDropdownOpen = false;

                                  return Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: PopupMenuButton<String>(
                                      onSelected: (value) {
                                        if (value == 'logout') {
                                          // Implement your logout logic here
                                          print("User selected Logout");
                                        }
                                      },
                                      onCanceled: () {
                                        setState(() {
                                          isDropdownOpen = false;
                                        });
                                      },
                                      onOpened: () {
                                        setState(() {
                                          isDropdownOpen = true;
                                        });
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          PopupMenuItem<String>(
                                            value: 'logout',
                                            child: Row(
                                              children: [
                                                Icon(Icons.logout, color: Colors.black),
                                                SizedBox(width: 8),
                                                Text('Logout'),
                                              ],
                                            ),
                                          ),
                                        ];
                                      },
                                      // Animated rotation of the icon
                                      child: AnimatedRotation(
                                        turns: isDropdownOpen ? 0.5 : 0.0, // Rotate 180 degrees when open
                                        duration: Duration(milliseconds: 200), // Duration of the animation
                                        child: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Positioning the menu below the app bar
                                      offset: Offset(0, AppBar().preferredSize.height),
                                    ),
                                  );
                                },
                              ),
                            ],
                          )




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







