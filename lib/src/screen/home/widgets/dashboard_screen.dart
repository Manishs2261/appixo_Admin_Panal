
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/custom_card_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomCardWidgets(
                  title: 'Total Users',
                  totalUser: '255',
                ),
                CustomCardWidgets(
                  title: 'Total Rooms',
                  totalUser: '255',
                ),
                CustomCardWidgets(
                  title: 'Total Foods',
                  totalUser: '255',
                ),
                CustomCardWidgets(
                  title: 'Total Deals',
                  totalUser: '255',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
