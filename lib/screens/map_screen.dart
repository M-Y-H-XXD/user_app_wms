import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:wms/generated/l10n.dart';
import 'package:wms/screens/distribution_centers_sorted.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.productID});
  final int productID;
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  Location location = Location();
  LocationData? currentLocation;
  bool hasLocationPermission = false;
  LatLng? selectedLocation;
  late bool isLoad;
  @override
  void initState() {
    isLoad = true;
    super.initState();
    check();
  }

  void check() {
    _checkPermissions();
    isLoad = false;
    setState(() {});
  }

  Future<void> _checkPermissions() async {
    // 1- تأكد أن خدمة الـ GPS شغالة
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        setState(() {
          hasLocationPermission = false;
        });
        return;
      }
    }

    // 2- تأكد من إذن الوصول للموقع
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    // 3- لو تمت الموافقة
    if (permissionGranted == PermissionStatus.granted) {
      hasLocationPermission = true;
      currentLocation = await location.getLocation();
      setState(() {});
    } else {
      // 4- لو تم الرفض
      setState(() {
        hasLocationPermission = false;
        currentLocation = null;
      });
    }
  }

  void _onTapMap({required LatLng point, required BuildContext context}) {
    setState(() {
      selectedLocation = point; // تخزين الموقع المحدد
    });
    //print('Selected location: $selectedLocation');
    print(
      'Selected location: Latitude: ${point.latitude}, Longitude: ${point.longitude}',
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => DistributionCentersSorted(
              productID: widget.productID,
              latitude: point.latitude,
              longitude: point.longitude,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).choose_location)),
      body:
          isLoad
              ? const Center(child: CircularProgressIndicator())
              : hasLocationPermission
              ? FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  // initialCenter:
                  // currentLocation != null
                  //     ? LatLng(
                  //       currentLocation!.latitude!,
                  //       currentLocation!.longitude!,
                  //     )
                  //     : const LatLng(34.8021, 38.9968), //
                  initialCenter: const LatLng(
                    34.8021,
                    38.9968,
                  ), //syria the center
                  initialZoom: 6.0,
                  onTap:
                      (tapPosition, point) =>
                          _onTapMap(point: point, context: context),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: "com.example.wms",
                  ),

                  MarkerLayer(
                    markers: [
                      if (currentLocation != null)
                        Marker(
                          point: LatLng(
                            currentLocation!.latitude!,
                            currentLocation!.longitude!,
                          ),
                          width: 80.0,
                          height: 80.0,
                          child: Container(
                            child: const Icon(
                              Icons.my_location,
                              color: Colors.blue,
                              size: 40.0,
                            ),
                          ),
                        ),
                      if (selectedLocation != null)
                        Marker(
                          point: selectedLocation!,
                          width: 80.0,
                          height: 80.0,
                          child: Container(
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 40.0,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              )
              : Center(
                child: Text(
                  S
                      .of(context)
                      .Permission_to_access_location_is_denied_Please_enable_it_in_settings,
                  textAlign: TextAlign.center,
                ),
              ),
    );
  }
}
