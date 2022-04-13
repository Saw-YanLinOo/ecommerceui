import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerceui/config/config.dart';
import 'package:ecommerceui/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';

class Setting extends StatelessWidget {

  static String route = '/setting';
  late String selectLanguage;

  final Map<String,String> languageList = {
    "en_US":"English",
    "my_MM":"မြန်မာ",
  };

  Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    selectLanguage = EasyLocalization.of(context)!.locale.toString();

    return WillPopScope(
      onWillPop: () async{
        Navigator.pushNamedAndRemoveUntil(context, Home.route, (route) => false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'setting'.tr(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                        child: Text(Theme.of(context).brightness == Brightness.light ? 'light_theme'.tr() : 'dart_theme'.tr())),
                    Positioned.fill(
                      top: 80,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: DropdownButton<String>(
                            value: provider.currentTheme,
                            items: [
                              //Light, dark, and system
                              DropdownMenuItem<String>(
                                value: 'light',
                                child: Text(
                                  'Light',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),

                              DropdownMenuItem<String>(
                                value: 'dark',
                                child: Text(
                                  'Dark',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'system',
                                child: Text(
                                  'System',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                            ],
                            onChanged: (String? value) {
                              provider.changeTheme(value ?? 'system');
                            },
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30,left: 20,bottom: 10,right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('language'.tr()),
                          GestureDetector(
                            onTap: () async {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                // false = user must tap button, true = tap outside dialog
                                builder: (BuildContext dialogContext) {
                                  return LanguageDialog(
                                      selectLanguage: selectLanguage,
                                      languageList: languageList
                                  );
                                },
                              );
                            },
                            child: Text('edit'.tr(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30,left: 20,top: 10,right: 20),
                      child: Text('change_language'.tr(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageDialog extends StatefulWidget {
  final String selectLanguage;
  final Map<String,String> languageList;

  const LanguageDialog({Key? key,required this.selectLanguage,required this.languageList}) : super(key: key);

  @override
  _LanguageDialogState createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {

  late String selectLanguage = widget.selectLanguage;
  late Map<String,String> languageList = widget.languageList;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Language'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: languageList.length,
          itemBuilder:(context,index){
            return ListTile(
              leading: Radio(
                value: languageList.keys.elementAt(index),
                groupValue: selectLanguage,
                onChanged: (value){
                  setState(() {
                    selectLanguage = value.toString();
                  });
                },
              ),
              title: Text(languageList.values.elementAt(index)),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          child: Text('cancel'.tr()),
          onPressed: () {
            Navigator.of(context)
                .pop(); // Dismiss alert dialog
          },
        ),
        TextButton(
          child: Text('select'.tr()),
          onPressed: () {
            context.setLocale(Locale(selectLanguage.split('_').first,selectLanguage.split('_').last));
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}


