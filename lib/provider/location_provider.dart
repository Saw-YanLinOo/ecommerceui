import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider extends ChangeNotifier{
  Position? _position;
  Position get getPosition => _position!;

  String _finalAddress = 'Searching Address..';
  String get getFinalAddress => _finalAddress;

  String countryName = 'Myanmar';
  String get getCountryName => countryName;

  String mainAddress = 'Your Address';
  String get getMainAddress => mainAddress;


  // GoogleMapController? googleMapController;

  Map<String, Marker> markers = {};

  Future getCurrentLocation() async{

    var positionData = await GeolocatorPlatform.instance.getCurrentPosition();

    var address = await placemarkFromCoordinates(positionData.latitude, positionData.longitude);

    _finalAddress = address.first.name!;

    notifyListeners();
  }

  // void onMapCreated(GoogleMapController controller) {
  //   googleMapController = controller;
  //   notifyListeners();
  // }

  getMarker(double lat,double long){
    MarkerId markerId = MarkerId(lat.toString()+long.toString());
    Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(lat,long),
      infoWindow: InfoWindow(title: mainAddress,snippet: countryName),
    );
    //markers.isEmpty ? markers[markerId] = marker : markers.clear();
    markers['markerId'] = marker;
    notifyListeners();
  }

  void fetchMap(LatLng latLng) async{
    var address = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    countryName = address.first.country!;
    mainAddress = address.first.name!;
    getMarker(latLng.latitude, latLng.longitude);
    notifyListeners();
  }

}