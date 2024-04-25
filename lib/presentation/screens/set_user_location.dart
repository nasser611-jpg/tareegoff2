import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onMapTap(LatLng location) async {
    setState(() {
      selectedLatitude = location.latitude;
      selectedLongitude = location.longitude;
    });

    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    if (placemarks != null && placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      setState(() {
        selectedAddress =
            '${placemark.street}, ${placemark.locality}, ${placemark.subAdministrativeArea}';
      });
    }
  }

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
                target: LatLng(14.540715320428557,
                    49.127207399530086), // Default initial location (San Francisco)
                zoom: 12.0,
              ),
              markers: selectedLatitude == null || selectedLongitude == null
                  ? Set<Marker>()
                  : {
                      Marker(
                        markerId: MarkerId('selected_location'),
                        position: LatLng(selectedLatitude!, selectedLongitude!),
                      ),
                    },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              selectedAddress ?? 'Tap on the map to select a location',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
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
