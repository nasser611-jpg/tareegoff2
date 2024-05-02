import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tareegoff22/presentation/widgets/custom_app_bar.dart';

class GoogleMapsScreen extends StatefulWidget {
  final double lan, long;

  GoogleMapsScreen({Key? key, required this.lan, required this.long})
      : super(key: key);

  @override
  _GoogleMapsScreenState createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  late GoogleMapController mapController;

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        markerId: const MarkerId('myMarker'),
        position: LatLng(widget.lan, widget.long),
        infoWindow: const InfoWindow(
          title: 'الموقع العطل', // Specify the title here
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('تفاصيل الموقع', Icons.location_on_rounded),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.lan, widget.long),
          zoom: 18.0,
        ),
        mapType: MapType.normal,
        markers: _markers,
      ),
    );
  }
}
