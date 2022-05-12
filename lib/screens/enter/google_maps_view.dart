import 'dart:async';

import 'package:barber_app/providers/shop_info.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

enum MapSituation { loading, error, success }

class GoogleMapsView extends StatefulWidget {
  @override
  State<GoogleMapsView> createState() => GoogleMapsViewState();
}

class GoogleMapsViewState extends State<GoogleMapsView> {
  final Completer<GoogleMapController> _controller = Completer();
  late CameraPosition _kGooglePlex;

  MapSituation mapSituation = MapSituation.loading;
  bool isCurrentLocationCatch = false;

  Marker targetPlace = const Marker(
    markerId: MarkerId('target'),
  );
  bool isSelectAnyPlace = false;

  Future<void> preparingMap() async {
    Position currentPosition = await _determinePosition();
    setState(() {
      isCurrentLocationCatch = true;
    });

    if (mapSituation == MapSituation.success && isCurrentLocationCatch) {
      _kGooglePlex = CameraPosition(
        target: LatLng(currentPosition.latitude, currentPosition.longitude),
        zoom: 14.4746,
      );
    }
  }

  @override
  void initState() {
    preparingMap();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// For initialing the former location
    if (Provider.of<ShopInfo>(context, listen: false).shop.lat != 0 &&
        Provider.of<ShopInfo>(context, listen: false).shop.lng != 0 &&
        !isSelectAnyPlace) {
      targetPlace = Marker(
        markerId: const MarkerId('target'),
        infoWindow: const InfoWindow(title: 'Target'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: LatLng(Provider.of<ShopInfo>(context, listen: false).shop.lat,
            Provider.of<ShopInfo>(context, listen: false).shop.lng),
      );
      isSelectAnyPlace = true;
    }

    return Scaffold(
      body: mapSituation == MapSituation.success && isCurrentLocationCatch
          ? GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: {
                if (targetPlace != null) targetPlace,
              },
              onLongPress: _addMarker,
            )
          : mapSituation == MapSituation.error
              ? const Center(
                  child: Text('Error'),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isSelectAnyPlace) {
            Provider.of<ShopInfo>(context, listen: false).updateLatLng(
                targetPlace.position.latitude, targetPlace.position.longitude);
            Navigator.pop(context);
          } else {
            print('Please select any place');
          }
        },
        child: const Icon(
          Icons.done,
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      setState(() {
        mapSituation = MapSituation.error;
      });
      return Future.error('Location services are disabled.');
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
        setState(() {
          mapSituation = MapSituation.error;
        });
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      setState(() {
        mapSituation = MapSituation.error;
      });
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    setState(() {
      mapSituation = MapSituation.success;
    });
    return await Geolocator.getCurrentPosition();
  }

  void _addMarker(LatLng pos) {
    setState(() {
      targetPlace = Marker(
        markerId: const MarkerId('target'),
        infoWindow: const InfoWindow(title: 'Target'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: pos,
      );
      isSelectAnyPlace = true;
    });
  }
}
