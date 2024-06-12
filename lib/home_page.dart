import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import 'constants/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var languages = ['Urdu', 'English', 'Arabic'];
  var originLanguage = "From";
  var destinationLanguage = "To";
  var output = "";
  TextEditingController languageController = TextEditingController();

  void translate(String src, String dest, String input) async {
    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });
    if (src == '--' || dest == '--') {
      setState(() {
        output = 'Failed To Translate';
      });
    }
  }

  String getLanguageCode(String language) {
    if (language == "English") {
      return "en";
    } else if (language == "Urdu") {
      return "ur";
    } else if (language == "Arabic") {
      return "ar";
    }
    return "--";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: const Text(
          'GlobalTalk',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: blueClr,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: blueClr,
                    iconEnabledColor: blueClr,
                    hint: Text(
                      originLanguage,
                      style: const TextStyle(color: blueClr,fontWeight: FontWeight.w600),
                    ),
                    dropdownColor: blueClr,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originLanguage = value!;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset('assets/app_logo.png'),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: blueClr,
                    iconEnabledColor: blueClr,
                    hint: Text(
                      destinationLanguage,
                      style: const TextStyle(color: blueClr,fontWeight: FontWeight.w600),
                    ),
                    dropdownColor: blueClr,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        destinationLanguage = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  cursorColor: blueClr,
                  autofocus: false,
                  style: const TextStyle(color: blueClr, fontWeight: FontWeight.w700),
                  decoration: InputDecoration(
                    labelText: 'Please Enter Your Text',
                    labelStyle: const TextStyle(fontSize: 15, color: blueClr, fontWeight: FontWeight.w700),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: blueClr,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: blueClr,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: blueClr,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorStyle: const TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  controller: languageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Text";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      translate(
                          getLanguageCode(originLanguage),
                          getLanguageCode(destinationLanguage),
                          languageController.text.toString());
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: blueClr),
                    child: const Text("Translate",style: TextStyle(color: Colors.white, fontSize: 18),),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
               Text(
                "\n$output",
                style: const TextStyle(
                  color: blueClr,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
