import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';

class transApp extends StatefulWidget {
  const transApp({super.key});

  @override
  State<transApp> createState() => _transAppState();
}

class _transAppState extends State<transApp> {
  final translator = GoogleTranslator();
  var transtext = "";
  var langCodeFrom;
  var langCodeTo;
  var selectedValueFrom;
  var selectedValueTo;
  bool isLoading = false;
  TextEditingController _controller = TextEditingController();
  List<dynamic> langfrom = ["English", "Hindi", "French"];

  List<String> langCode = ["en", "hi", "fr"];

  translate() async {
    setState(() {
      isLoading = true;
    });
    await translator
        .translate(_controller.text, from: langCodeFrom, to: langCodeTo)
        .then((value) => transtext = value.toString());
    setState(() {
      isLoading = false;
    });
  }

  _launchURL() async {
    final Uri url = Uri.parse('https://github.com/thedevyash');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

// @override
// void initState()
// {
//   super.initState();
//   translate();
// }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      drawer: Drawer(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.width / 1.2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 58, 33, 243),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24))),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Version 1.0.0",
                      style: GoogleFonts.poppins(
                          fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: _launchURL,
                      child: Text(
                        "Github",
                        style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 58, 33, 243),
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 1,
                    ),
                    Text(
                      "Developed By  Yash",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )
            ]),
      ),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 58, 33, 243),
        title: Text(
          "EasyLingo",
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                constraints: BoxConstraints(minWidth: 300),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(24)),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "From",
                        style: GoogleFonts.poppins(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 20),
                            focusColor: Colors.transparent,
                            value: selectedValueFrom,
                            items: langfrom.map((lang) {
                              return DropdownMenuItem(
                                value: lang,
                                child: Text(lang),
                                onTap: () {
                                  if (lang == langfrom[0]) {
                                    langCodeFrom = langCode[0];
                                  } else if (lang == langfrom[1]) {
                                    langCodeFrom = langCode[1];
                                  } else if (lang == langfrom[2]) {
                                    langCodeFrom = langCode[2];
                                  }
                                },
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedValueFrom = value;
                              });
                            }),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "To",
                        style: GoogleFonts.poppins(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 20),
                            focusColor: Colors.transparent,
                            value: selectedValueTo,
                            items: langfrom.map((lang) {
                              return DropdownMenuItem(
                                value: lang,
                                child: Text(lang),
                                onTap: () {
                                  if (lang == langfrom[0]) {
                                    langCodeTo = langCode[0];
                                  } else if (lang == langfrom[1]) {
                                    langCodeTo = langCode[1];
                                  } else if (lang == langfrom[2]) {
                                    langCodeTo = langCode[2];
                                  }
                                },
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedValueTo = value;
                              });
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                constraints: BoxConstraints(minWidth: 300, minHeight: 250),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(24)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedValueFrom == null
                            ? "Select Language"
                            : selectedValueFrom,
                        style: GoogleFonts.poppins(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLines: 5,
                        style: GoogleFonts.poppins(fontSize: 22),
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            hintText: "Enter Text",
                            hintStyle:
                                GoogleFonts.poppins(color: Colors.grey[600])),
                        controller: _controller,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (selectedValueFrom != null &&
                              selectedValueTo != null &&
                              _controller.text != "") {
                            setState(() {
                              translate();
                            });
                          } else if ((selectedValueFrom == null ||
                                  selectedValueTo == null) &&
                              _controller.text != "") {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.white,
                                content: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    "C'mmon Man...select the languages first !!",
                                    style: GoogleFonts.poppins(fontSize: 22),
                                  ),
                                ),
                              ),
                            );
                          } else if ((selectedValueFrom != null ||
                                  selectedValueTo != null) &&
                              _controller.text == "") {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.white,
                                content: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    "C'mmon Man...enter the text to translate !!",
                                    style: GoogleFonts.poppins(fontSize: 22),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: Colors.white,
                                content: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    "C'mmon Man...enter everything !!",
                                    style: GoogleFonts.poppins(fontSize: 22),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: Center(
                          child: Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: isLoading
                                    ? SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                            strokeAlign: -0.5,
                                            color: Colors.white),
                                      )
                                    : Text(
                                        "Translate",
                                        style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                constraints: BoxConstraints(minWidth: 400, minHeight: 280),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(24)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedValueTo == null
                            ? "Select Language"
                            : selectedValueTo,
                        style: GoogleFonts.poppins(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        transtext,
                        style: GoogleFonts.poppins(fontSize: 22),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
