import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:untitled/add_order/add_order.dart';

import 'delivery_boy/delivery_boy.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, foregroundColor: Colors.white),
              onPressed: () {
                Get.to(const AddOrderPage());
              },
              child: const Text("Client app"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, foregroundColor: Colors.white),
              onPressed: () {
                Get.to(const DEliveryBoyPage());
              },
              child: const Text("Delivery boy app"),
            )
          ],
        ),
      ),
    );
  }
}
