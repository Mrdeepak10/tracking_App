import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/model/my_order.dart';

class AddOrderController extends GetxController {
  TextEditingController orderIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  GoogleMapController? mapController;

  LatLng currentLocation = LatLng(0, 0);
  LatLng selectedLocation = LatLng(0, 0);

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  late CollectionReference orderCollection;

  @override
  Future<void> onInit() async {
    orderCollection = fireStore.collection('order');
    super.onInit();
  }

  void addOrder(BuildContext context) {
    try {
      if (nameController.text.isEmpty ||
          orderIdController.text.isEmpty ||
          amountController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please fill field"),
          ),
        );
        return;
      } else {
        DocumentReference doc = orderCollection.doc(orderIdController.text);
        MyOrder order = MyOrder(
          id: doc.id,
          phone: phoneController.text,
          address: addressController.text,
          name: nameController.text,
          amount: double.parse(amountController.text),
          latitude: selectedLocation!.latitude.toDouble(),
          longitude: selectedLocation!.longitude.toDouble(),
        );
        final orderJson = order.toJson();
        doc.set(orderJson);
        clearTextFields();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Order added successfully"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to add order"),
        ),
      );
    }
  }

  clearTextFields() {
    orderIdController.clear();
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    amountController.clear();
  }
}
