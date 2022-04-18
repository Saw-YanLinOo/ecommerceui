import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerceui/provider/packet_version_provider.dart';
import 'package:ecommerceui/screen/drawer/setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeDrawer extends StatelessWidget {
  const HomeDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var packageProvider = Provider.of<PackageProvider>(context);
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: ListView(
              children: [
                const UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image(
                      width: 50,
                      height: 50,
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/human_icon.png'),
                    ),
                  ),
                  accountName: Text(
                    'User Name',
                    style: TextStyle(
                        fontSize: 14,
                        ),
                  ),
                  accountEmail: Text(
                    'user@gmail.com',
                    style: TextStyle(
                        fontSize: 12,
                        ),
                  ),
                ),
                itemUI(
                    name: 'profile'.tr(),
                    icon: Icons.person,
                    onTap: (){

                    }),
                itemUI(
                    name: 'setting'.tr(),
                    icon: Icons.settings,
                    onTap: (){
                      Navigator.pushNamed(context,Setting.route);
                }),
                const Divider(),
                itemUI(
                    name: 'logout'.tr(),
                    icon: null,
                    onTap: (){
                    }),
              ],
            ),
          ),
          Container(
            alignment: AlignmentDirectional.centerStart,
            padding: EdgeInsets.all(10),
            child: Text(
                'Version - ${packageProvider.appVersion}'
            ),
          ),
        ],
      ),
    );
  }

  itemUI({required String name,
    IconData? icon,
    required Function() onTap,
    bool my = false,
    bool enable = true}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      onTap: onTap
    );
  }
}