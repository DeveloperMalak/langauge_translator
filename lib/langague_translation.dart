import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslationPage extends StatefulWidget {
  const LanguageTranslationPage({Key? key}) : super(key: key);
  @override
  State<LanguageTranslationPage> createState() => _LanguageTranslationPageState();
}

class _LanguageTranslationPageState extends State<LanguageTranslationPage> {
  var languages = ['Hindi', 'English', 'Arabic'];//these are our some langauge
  var originLanguage = 'From';//first value apperar at dropdown butotn
  var destinationLanguage = 'To';//destination
  var output = '';//output whih will be printed
  TextEditingController languageController = TextEditingController();
  void translate(String src, String dest, String input) async {
    if (src == '--' || dest == '--') {//her if src and dest==null so we ill initialize out pu twith erro message
      setState(() {
        output = 'Fails to translate';//with setState we have passed this message to the output
      });
      return;//we have returned
    }

    GoogleTranslator translator = GoogleTranslator();//here we made a object  from our class
    var translation = await translator.translate(input, from: src, to: dest);//here we have varible translation in whih we will store value of the transalor.translateor object
    setState(() {
      output = translation.text;//we have passed our translation value to the output
    });
  }
//here we made a funtion to make code fo our langauges
  String getLanguageCode(String language) {//here we have created a languge cod e hwi our google translate cna understand
    switch (language) {
      case 'English':
        return 'en';//code that googel understand
      case 'Hindi':
        return 'hi';
      case 'Arabic':
        return 'ar';
      default:
        return '--';//if no langaue matches so then return this null
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Language Translator',style:TextStyle(color:Colors.white)),
        elevation: 0,
        backgroundColor: Color(0xff10223d),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(//here we have made a dropdownbutton widget
                    focusColor: Colors.white,//with all these detaisl
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(originLanguage,//in the hint teext we have originLangague
                        style: TextStyle(color: Colors.white)),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String language) {//we mapped oru langauges list
                      return DropdownMenuItem<String>(//adn passed the value to the DropdownMenuItem
                        child: Text(language),//in the text widget
                        value: language,
                      );
                    }).toList(),//and to lIst
                    onChanged: (String? value) {
                      setState(() {//if oncanggd he value of drop down changed origin lngauge ould bechanged
                        originLanguage = value!;
                      });
                    },
                  ),
                  SizedBox(width: 40),
                  Icon(Icons.arrow_right_alt_outlined, color: Colors.white, size: 40),
                  SizedBox(width: 40),
                  DropdownButton<String>(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(destinationLanguage,
                        style: TextStyle(color: Colors.white)),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                    items: languages.map((String language) {//we have mapped oru list
                      return DropdownMenuItem<String>(
                        child: Text(language),
                        value: language,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        destinationLanguage = value!;//on cahnged value of the s willbe chagned too
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  cursorColor: Colors.white,
                  autofocus: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Please enter text',
                    labelText: 'Please enter your text',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 15),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  controller: languageController,//we have passed the contoller value of our controlelr
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter text to translate';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFFFFF),
                  ),
                  onPressed: () {
                    translate(
                      getLanguageCode(originLanguage),//this is the src
                      getLanguageCode(destinationLanguage),//thsi is the dest
                      languageController.text.toString(),//this is the input
                    );
                  },
                  child: Text('Translate'),
                ),
              ),
              SizedBox(height: 20),
              Text(
                output,//here will be our output translation
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
