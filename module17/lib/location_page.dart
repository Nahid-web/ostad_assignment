import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Location location = Location();
  late GoogleMapController googleMapController;
  final LatLng sourcePosition =
      const LatLng(24.29412308011084, 89.08066754203058);
  final LatLng currentPosition =
      const LatLng(24.30070400754022, 89.07941226829702);

  void getCurrentLocation() async {

    LocationData currentLocation = await location.getLocation();


    //if location changed
    // location.onLocationChanged.listen(
    //   (newLocation) {
    //     currentLocation = newLocation;
    //     googleMapController.animateCamera(
    //       CameraUpdate.newCameraPosition(
    //         CameraPosition(
    //           target: LatLng(newLocation.longitude!, newLocation.latitude!),
    //           zoom: 5,
    //         ),
    //       ),
    //     );
    //     setState(() {
    //
    //     });
    //   },
    // );

    googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentLocation!.longitude!, currentLocation!.latitude!), zoom: 14)));

  }

  @override
  void initState() {
    // getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real Time Location Tracker'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: currentPosition,
          zoom: 17,
          bearing: 40
        ),
        markers: {
          Marker(
            markerId: MarkerId('Current Position'),
            position: currentPosition,
            infoWindow: InfoWindow(
              title: 'Current Position',
            ),
          ),

        },
        polylines: {
          Polyline(
            polylineId: PolylineId('Source to Current Position'),
            points: [
              sourcePosition,
              currentPosition,
            ],
            width: 5,
            color: Colors.red
          )
        },

        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
      ),
    );
  }
}
