import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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