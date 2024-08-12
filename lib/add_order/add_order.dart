import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/add_order/add_order_controller.dart';

import '../live_tracking/live_tracking_page.dart';
import '../order_list/order_list.dart';

class AddOrderPage extends StatefulWidget {
  const AddOrderPage({Key? key}) : super(key: key);

  @override
  State<AddOrderPage> createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddOrderController>(
        init: AddOrderController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Order Details"),
              actions: [
                IconButton(
                  onPressed: () {
                    Get.to(const OrderListPage());
                  },
                  icon: Icon(Icons.list),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.map_outlined),
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  TextField(
                    controller: controller.orderIdController,
                    decoration: const InputDecoration(labelText: "Order Id"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: controller.nameController,
                    decoration:
                        const InputDecoration(labelText: "Customer Name"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: controller.phoneController,
                    decoration:
                        const InputDecoration(labelText: "Customer Phone"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: controller.addressController,
                    decoration:
                        const InputDecoration(labelText: "Customer Address"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: controller.amountController,
                    decoration: const InputDecoration(labelText: "Bill Amount"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8)),
                    child: GoogleMap(
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      onMapCreated: (GoogleMapController mapController) {
                        controller.mapController = mapController;
                      },
                      onTap: (latLog) {
                        controller.selectedLocation = latLog;
                        controller.update();
                      },
                      markers: {
                        Marker(
                            markerId: const MarkerId('selectedLocation'),
                            position: controller.selectedLocation!,
                            infoWindow: InfoWindow(
                                title: 'Selected Location',
                                snippet:
                                    "Lat: ${controller.selectedLocation!.latitude}, Lng: ${controller.selectedLocation!.longitude}"))
                      },
                      initialCameraPosition:
                          const CameraPosition(target: LatLng(22.962267, 76.050797), zoom: 14),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        controller.addOrder(context);
                      },
                      child: const Text("Submit order"),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
