import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerceui/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';


class GoogleMapLocation extends StatefulWidget {
  const GoogleMapLocation({Key? key}) : super(key: key);

  @override
  State<GoogleMapLocation> createState() => _GoogleMapLocationState();
}

class _GoogleMapLocationState extends State<GoogleMapLocation> {
  Completer<GoogleMapController> mapController = Completer();

  final locationController = TextEditingController();
  final LatLng _center = const LatLng(21.913965, 95.956223);

  void _onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
  }

  void checkPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPermission();
  }
  @override
  Widget build(BuildContext context) {
    var locationProvider = Provider.of<LocationProvider>(context);
    locationController.text = locationProvider.getMainAddress +', '+ locationProvider.countryName;

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
              mapType: MapType.hybrid,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              onTap: (val) async {
                locationProvider.fetchMap(val);
              },
              markers: locationProvider.markers.values.toSet(),
            padding: const EdgeInsets.only(top: 100),
            ),
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: locationController,
                readOnly: true,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).primaryColor,
                    hintText: 'Enter your Location',
                    prefixIcon: const Icon(Icons.location_on),
                    contentPadding: const EdgeInsets.only(left: 20,bottom: 5,right: 5),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Theme.of(context).primaryColor)
                    )
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
                child: Text('confirm'.tr()),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    locationController.dispose();
  }
}

