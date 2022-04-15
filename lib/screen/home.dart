import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerceui/provider/location_provider.dart';
import 'package:ecommerceui/screen/drawer.dart';
import 'package:ecommerceui/screen/drawer/map.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  
  const Home({ Key? key }) : super(key: key);

  static String route = '/home';
  @override
  Widget build(BuildContext context) {
    var locationProvider = Provider.of<LocationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const GoogleMapLocation()));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'current_location'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                ),
                ),
              Row(
                children: [
                  const Icon
                    (Icons.location_on,
                    size: 16,
                  ),
                  Text(
                    locationProvider.mainAddress + locationProvider.countryName,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                    ),
                ],
              )
            ],
          ),
        ),
        actions: [
          InkWell(
            onTap: (){

            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.card_travel,
              ),
            ),
          )
        ],
      ),
      drawer: const HomeDrawer(),
    );
  }
}