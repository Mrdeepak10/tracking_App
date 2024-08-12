import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:untitled/model/my_order.dart';

class LiveTrackingController extends GetxController {
  MyOrder? myOrder;

  String orderId = "000";
  LatLng destination = LatLng(22.962267, 76.050797);
  LatLng deliveryBoyLocation = LatLng(76.9924, 76.049797);

  GoogleMapController? mapController;
  BitmapDescriptor marrkerIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
  double remainingDistance = 0.0;
  final Location location = Location();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference orderTrackingCollection;

  @override
  void onInit() {
    orderTrackingCollection = firestore.collection('orderTracking');
    addCustomMarker();
    super.onInit();
  }

  void addCustomMarker() {
    ImageConfiguration configuration =
    const ImageConfiguration(size: Size(0,0),devicePixelRatio: 0);
    BitmapDescriptor.fromAssetImage(configuration, "assets/deliveryboy.jpeg")
        .then((value) {
      marrkerIcon = value;
    });
  }

  void updateCurrentLocation(double latitude, double longitude) {
    destination = LatLng(latitude, longitude);
    update();
  }

  void startTracking(String orderId) {
    try {
      orderTrackingCollection.doc(orderId).snapshots().listen((snapshot) {
        if (snapshot.exists) {
          var trackingDate = snapshot.data() as Map<String, dynamic>;
          double latitude = trackingDate['latitude'];
          double longitude = trackingDate['longitude'];
          updateUIWithLocation(latitude, longitude);
          print("Latest location: $latitude, $longitude");
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  void updateUIWithLocation(double latitude, double longitude) {
    deliveryBoyLocation = LatLng(latitude, longitude);

    mapController?.animateCamera(CameraUpdate.newLatLng(deliveryBoyLocation));
      calculateRemainingDistance();

  }

  void calculateRemainingDistance() {
    double distance = Geolocator.distanceBetween(
        deliveryBoyLocation.latitude,
        deliveryBoyLocation.longitude,
        destination.latitude,
        destination.longitude);

    double distanceInKm = distance / 1000;

    remainingDistance = distanceInKm;
    print("Remaing Distance: $distanceInKm kilometers");
    update();
  }
}
