import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/data/response/status.dart';
import 'package:getx_tutorial/routes/route_constants.dart';
import 'package:getx_tutorial/screens/dashboard/controller/dashboard_controller.dart';
import 'package:getx_tutorial/utils/shimmer_util/shimmer_view.dart';
import 'package:permission_handler/permission_handler.dart';

//ignore:must_be_immutable
class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController dashboardController =
      Get.put(DashboardController());
  String currentAddress = 'Getting address.....';

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dashboardController.category
        .addAll(dashboardController.mealCategoryList.value.categories ?? []);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(Icons.person_3_outlined, color: Colors.red[400]),
            const SizedBox(width: 4.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Username",
                    style: TextStyle(fontSize: 12.0, color: Colors.red[400])),
                Row(
                  children: [
                    Icon(Icons.location_on,
                        size: 12, color: Colors.red.shade400),
                    SizedBox(
                      width: 180,
                      child: Text(
                          currentAddress.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 10.0, color: Colors.red[400])),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.notifications, color: Colors.red[400]),
          )
        ],
      ),
      body: Obx(() => switch (dashboardController.rxRequestStatus.value) {
            Status.LOADING => const ShimmerView(shimmerType: "grid"),
            Status.COMPLETED => Padding(
                padding: const EdgeInsets.all(8.0),
                child: _dashboardView(context),
              ),
            Status.ERROR => const Column(
                children: [
                  Icon(Icons.signal_cellular_connected_no_internet_0_bar_sharp),
                  Text("Error fetching data")
                ],
              ),
          }),
    );
  }

  Widget _dashboardView(context) {
    var category = dashboardController.mealCategoryList.value.categories ?? [];
    return GridView.builder(
        itemCount: category.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two columns
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 2.0, // Adjust width-to-height ratio of items
        ),
        itemBuilder: (context, index) => GestureDetector(
              onTap: () => Get.toNamed(mealScreen,
                  arguments: category[index].strCategory),
              child: GridTile(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                          height: MediaQuery.sizeOf(context).height * 0.1,
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          fit: BoxFit.contain,
                          category[index].strCategoryThumb ??
                              'https://via.placeholder.com/150' // Placeholder image URL
                          ),
                      Text(
                        category[index].strCategory ?? '',
                        style: const TextStyle(color: Colors.black),
                      )
                    ]),
              ),
            ));
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _getAddressFromLatLng(position);
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          currentAddress =
              '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
        });
      }
    } catch (e) {
      setState(() {
        currentAddress = 'Failed to get address';
      });
    }
  }
}
