import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerceui/screen/drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  
  const Home({ Key? key }) : super(key: key);

  static String route = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'current_location'.tr(),
              style: const TextStyle(
                fontSize: 16,
              ),
              ),
            const Text(
              'Mawlamyine',
              style: TextStyle(
                fontSize: 12,
              ),
              )
          ],
        ),
        actions: [
          InkWell(
            onTap: (){

            },
            child: const Icon(
              Icons.card_travel,
            ),
          )
        ],
      ),
      drawer: const HomeDrawer(),
    );
  }
}