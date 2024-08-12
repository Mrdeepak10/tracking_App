import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:untitled/delivery_boy/delivery_boy_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class DEliveryBoyPage extends StatefulWidget {
  const DEliveryBoyPage({Key? key}) : super(key: key);

  @override
  State<DEliveryBoyPage> createState() => _DEliveryBoyPageState();
}

class _DEliveryBoyPageState extends State<DEliveryBoyPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryBoyController>(
      init:DeliveryBoyController(),
        builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Delivery Boy App'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Image.network(
                "https://img.freepik.com/free-vector/way-concept-illustration_114360-1191.jpg?semt=sph",
                height: 200,
                width: 200,
              ),
              Text(
                "Enter MyOrder ID:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: controller.orderIdController,
                decoration: InputDecoration(
                    hintText: 'MyOrder ID', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 16,
              ),
              Visibility(
                  visible: !controller.showDeliveryInfo,
                  child: ElevatedButton(
                    onPressed: () async {
                      controller.getOrderById();

                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )),
              SizedBox(
                height: 16,
              ),
              Visibility(
                visible: controller.showDeliveryInfo,
                child: Column(children: [
                   Text(
                    "Delivery Address: ${controller.deliveryAddress}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        "Phone Number: ${controller.phoneNumber}",
                        style: TextStyle(fontSize: 18),
                      ),
                      IconButton(
                          onPressed: () {
                            launch('tel: ${controller.phoneNumber}');
                          }, icon: Icon(Icons.call))
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Amount to Collect: \$ ${controller.amountToCollect}",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          launchUrl(Uri.parse(
                              "https://www.google.com/map?q=${controller.customerLatitude},${controller.customerLongitude}"));
                        },
                        icon: const Icon(Icons.location_on),
                        label: const Text("Show Location"),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white),
                          onPressed: () {
                            controller.startDelivery();
                          },
                          child: const Text("Start Delivery"))
                    ],
                  )
                ]),
              )
            ],
          ),
        ),
      );
    });
  }
}
