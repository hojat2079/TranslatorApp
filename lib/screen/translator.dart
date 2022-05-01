import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator/translator.dart';
import 'package:translator_app/component/input_field.dart';
import 'package:translator_app/model/language_type.dart';

class TranslatorPage extends StatefulWidget {
  const TranslatorPage({Key? key}) : super(key: key);

  @override
  State<TranslatorPage> createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {
  final GoogleTranslator translator = GoogleTranslator();
  final txtTranslate = TextEditingController();
  LanguageType languageType = LanguageType.en;
  final List<String> languages = [
    'Persian',
    'English',
  ];
  String selectFromLanguage = 'English';
  String selectToLanguage = 'Persian';

  String data = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
                child: Center(
                  child: Text(
                    'اپلیکیشن مترجم',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'CustomFont',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomInputField(
                            title: 'From',
                            hint: selectFromLanguage,
                            widget: _customDropDown(
                                list: languages,
                                iconData: Icons.keyboard_arrow_down_outlined,
                                fromLanguage: true),
                          )),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: CustomInputField(
                              title: 'To',
                              hint: selectToLanguage,
                              widget: _customDropDown(
                                  list: languages.reversed.toList(),
                                  iconData: Icons.keyboard_arrow_down_outlined,
                                  fromLanguage: false),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Directionality(
                        textDirection: languageType == LanguageType.fa
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        child: TextFormField(
                          controller: txtTranslate,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            isDense: true,
                            label: Text(
                              languageType == LanguageType.fa
                                  ? 'متن ورودی'
                                  : 'Enter the Word',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: languageType == LanguageType.fa
                                      ? 'CustomFont'
                                      : GoogleFonts.lato().fontFamily),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.blue.withOpacity(0.5))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.blue)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (selectFromLanguage == selectToLanguage) {
                              setState(() {
                                data = '';
                              });
                              showSnackBar(context,
                                  'زبان ورودی و خروجی نمیتواند یکسان باشد!!');
                              return;
                            }
                            if (txtTranslate.text.isNotEmpty) {
                              translator
                                  .translate(txtTranslate.text,
                                      from: languageType == LanguageType.en
                                          ? 'en'
                                          : 'fa',
                                      to: languageType == LanguageType.en
                                          ? 'fa'
                                          : 'en')
                                  .then((value) {
                                setState(() {
                                  data = value.text;
                                });
                              });
                            }
                          },
                          style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                  const Size.fromHeight(50)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50)))),
                          child: const Center(
                            child: Text(
                              'ترجمه',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'CustomFont',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        data,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'CustomFont',
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  DropdownButton<String> _customDropDown({
    required List<String> list,
    required IconData iconData,
    required bool fromLanguage,
  }) {
    return DropdownButton(
      underline: const SizedBox(
        height: 0,
      ),
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          iconData,
          color: Colors.grey,
        ),
      ),
      iconSize: 28.0,
      onChanged: (String? value) {
        setState(() {
          fromLanguage
              ? selectFromLanguage = value ?? selectFromLanguage
              : selectToLanguage = value ?? selectToLanguage;
          if (fromLanguage) {
            selectFromLanguage == languages[0]
                ? languageType = LanguageType.fa
                : languageType = LanguageType.en;
          }
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          child: Text(value,
              style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ))),
          value: value,
        );
      }).toList(),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'CustomFont',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Colors.blue,
    ));
  }
}
