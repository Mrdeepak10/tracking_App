import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/live_tracking/live_tracking_controller.dart';
import 'package:untitled/model/my_order.dart';

class OrderTracking extends StatefulWidget {
  const OrderTracking({Key? key}) : super(key: key);

  @override
  State<OrderTracking> createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arg = Get.arguments;
    MyOrder order = arg['order'];

    return GetBuilder<LiveTrackingController>(
        init: LiveTrackingController(),
        builder: (controller) {
          controller.myOrder = order;
          controller.updateCurrentLocation(order.latitude, order.longitude);
          controller.startTracking(order.id);
          return Scaffold(
            appBar: AppBar(
              title: const Text("Order Tracking"),
            ),
            body: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  onMapCreated: (mpCtrl) {
                    controller.mapController = mpCtrl;
                  },
                  initialCameraPosition: CameraPosition(
                    target: controller.deliveryBoyLocation,
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                        markerId: const MarkerId('destination'),
                        position: controller.destination,
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueBlue),
                        infoWindow: InfoWindow(
                            title: "Destination",
                            snippet:
                                "Lat: ${controller.destination.latitude}, Lng: ${controller.destination.longitude}")),
                    Marker(
                        markerId: const MarkerId('deliveryBoy'),
                        position: controller.deliveryBoyLocation,
                        icon: controller.marrkerIcon,
                        infoWindow: InfoWindow(
                            title: "Delivery Boy",
                            snippet:
                                "Lat: ${controller.deliveryBoyLocation.latitude}, Lng: ${controller.deliveryBoyLocation.longitude}"))
                  },
                ),
                Positioned(
                    top: 16,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                            "Remaining Distance: ${controller.remainingDistance.toStringAsFixed(2)} kilometers"),
                      ),
                    ))
              ],
            ),
          );
        });
  }
}
