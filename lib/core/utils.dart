import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
Future<void> launchURLMap(String query) async {
  final Uri url =
      Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}

String formattedDateTime =
    DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

final ImagePicker _picker = ImagePicker();

// Method to capture an image using the camera
Future<void> takePicture() async {
  final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

  if (photo != null) {
    // Do something with the photo (e.g., display it in the UI, upload it, etc.)
  }
}

// Method to pick an image from the gallery
Future<void> pickImage() async {
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    // Do something with the image
  }
}

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  // ignore: unused_field
  LatLng _lastMapPosition = const LatLng(45.521563, -122.677433);
  String _address = "";

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  Future<void> _onMapTapped(LatLng location) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    if (placemarks.isNotEmpty) {
      setState(() {
        _lastMapPosition = location;
        _address =
            "${placemarks.first.name}, ${placemarks.first.locality}, ${placemarks.first.country}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              onCameraMove: _onCameraMove,
              onTap: _onMapTapped,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Selected Location: $_address'),
          ),
        ],
      ),
    );
  }
}

      CollectionReference user= FirebaseFirestore.instance.collection('categories');

  addCategory()async{
try{
// ignore: unused_local_variable
DocumentReference response=await  user.add({
   'email':FirebaseAuth.instance.currentUser!.email,
  'id':FirebaseAuth.instance.currentUser!.uid,
  'displayName':FirebaseAuth.instance.currentUser!.displayName
});

}catch(e){
  // ignore: avoid_print
  print('Erorr $e');
}}
  
String  imgUrl='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4tQgNhsEvF8Oh2oURhW15UQvorIoAEwXYdQ&s';

