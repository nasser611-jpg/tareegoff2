import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tareegoff22/core/styles.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tareegoff22/presentation/widgets/custom_app_bar.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  double? selectedLatitude;
  double? selectedLongitude;
  String? selectedAddress;
  LatLng initialPosition = const LatLng(15.8397295945703,
      48.4642478931523); // Default to San Francisco as fallback

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (initialPosition != const LatLng(15.8397295945703, 48.4642478931523)) {
      // Check if initialPosition is not the fallback
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(initialPosition, 12.0),
      );
    }
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      initialPosition = LatLng(position.latitude, position.longitude);
    });

    if (mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(initialPosition, 20),
      );
    }
  }

  void _onMapTap(LatLng location) async {
    setState(() {
      selectedLatitude = location.latitude;
      selectedLongitude = location.longitude;
    });

    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      setState(() {
        selectedAddress =
            '${placemark.street}, ${placemark.locality}, ${placemark.subAdministrativeArea}';
      });
    }
  }

  Set<Circle> circles = {
    Circle(
      circleId: const CircleId("current_location"),
      center: const LatLng(0, 0), // Placeholder values
      radius: 300, // Adjust the radius according to your needs
      fillColor: Colors.blue.withOpacity(0.5),
      strokeColor: Colors.blue,
      strokeWidth: 1,
    )
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('تحديد الموقع', Icons.location_on_rounded),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              onTap: _onMapTap,
              initialCameraPosition: CameraPosition(
                target:
                    initialPosition, // Use the dynamically determined position
                zoom: 12.0,
              ),
              markers: selectedLatitude == null || selectedLongitude == null
                  ? Set<Marker>()
                  : {
                      Marker(
                        markerId: const MarkerId('الموقع المحدد'),
                        position: LatLng(selectedLatitude!, selectedLongitude!),
                      ),
                    },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              selectedAddress ?? 'انقر على الخريطه لتحديد الموقع',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (selectedAddress == null) {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.question,
                        animType: AnimType.rightSlide,
                        headerAnimationLoop: true,
                        title: 'عفواً',
                        desc: 'الرجاء اختيار الموقع !...',
                        btnOkOnPress: () {},
                        btnOkText: 'حسناً')
                    .show();
              } else {
                Map<String, dynamic> mapData = {
                  'selectedLatitude': selectedLatitude,
                  'selectedLongitude': selectedLongitude,
                  'selectedAddress': selectedAddress
                };
                Navigator.pop(context, mapData);
              }
            },
            child: Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 211, 209, 209),
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Text(
                  'حفظ',
                  style: Styles.textStyle30Title.copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
