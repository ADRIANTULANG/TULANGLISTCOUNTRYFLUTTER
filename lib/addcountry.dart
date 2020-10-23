import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
// import 'package:firebase_core/firebase_core.dart';
// import 'main.dart';
// import 'dart:convert';

class AddCountry extends StatefulWidget {
  AddCountry({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AddCountryState createState() => _AddCountryState();
}

class _AddCountryState extends State<AddCountry> {
  final countryname = TextEditingController();
  final capital = TextEditingController();
  final region = TextEditingController();
  final abbv = TextEditingController();
  final callingcodes = TextEditingController();
  final population = TextEditingController();
  final currencies = TextEditingController();
  final languages = TextEditingController();
  final longitude = TextEditingController();
  final latitude = TextEditingController();

  String message = '';

  File image;
  String filename;
  String imageurl = '';
  String dialogboxwait = '';

  final picker = ImagePicker();

  void adddatacountry() {
    var url =
        "https://adrianlistcountries.000webhostapp.com/adddatacountries.php";
    try {
      http.post(url, body: {
        "countryname": countryname.text,
        "capital": capital.text,
        "region": region.text,
        "abbv": abbv.text,
        "callingcodes": callingcodes.text,
        "population": population.text,
        "currencies": currencies.text,
        "languages": languages.text,
        "longitude": longitude.text,
        "latitude": latitude.text,
        "flagurl": imageurl,
      });
    } catch (e) {
      print("error data function");
    }
  }

  Future getImage() async {
    var selectedImage = await picker.getImage(source: ImageSource.gallery);
    try {
      setState(() {
        image = File(selectedImage.path);
        print('image path  $image');
        filename = basename(image.path);
      });
    } catch (e) {
      print('No image selected.');
    }
  }

  Future<String> addImage() async {
    try {
      StorageReference ref = FirebaseStorage.instance.ref().child(filename);
      StorageUploadTask uploadTask = ref.putFile(image);
      var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      setState(() {
        imageurl = downUrl.toString();
        print("download $imageurl");
        adddatacountry();
        dialogboxwait = "Done!";
        return imageurl;
      });
    } catch (e) {
      print('error image');
    }
    return imageurl;
  }

  Widget uploadArea() {
    return Column(
      children: <Widget>[
        Image.file(image, width: 400, height: 200),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Country"),
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            new Padding(padding: EdgeInsets.only(top: 40)),
            new Container(
              height: 1700,
              width: 400,
              color: Colors.grey,
              child: Column(
                children: <Widget>[
                  new Container(
                    child: Column(
                      children: <Widget>[
                        new Padding(padding: EdgeInsets.only(top: 20)),
                        new Container(
                          height: 25,
                          width: 360,
                          child: new Text(
                            "Country Name: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        new Container(
                            width: 365,
                            child: new TextField(
                              controller: countryname,
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                        width: 20,
                                      )),
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                  hintText: "Enter Country Name",
                                  fillColor: Colors.white70),
                            )),
                        new Padding(padding: EdgeInsets.only(top: 20)),
                        new Container(
                          height: 25,
                          width: 360,
                          child: new Text(
                            "Capital: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        new Container(
                            width: 365,
                            child: new TextField(
                              controller: capital,
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                        width: 20,
                                      )),
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                  hintText: "Enter Capital of the Country",
                                  fillColor: Colors.white70),
                            )),
                        new Padding(padding: EdgeInsets.only(top: 20)),
                        new Container(
                          height: 25,
                          width: 360,
                          child: new Text(
                            "Region: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        new Container(
                            width: 365,
                            child: new TextField(
                              controller: region,
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                        width: 20,
                                      )),
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                  hintText: "Enter Number of Regions",
                                  fillColor: Colors.white70),
                            )),
                        new Padding(padding: EdgeInsets.only(top: 20)),
                        new Container(
                          height: 25,
                          width: 360,
                          child: new Text(
                            "Abbreviations: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        new Container(
                            width: 365,
                            child: new TextField(
                              controller: abbv,
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                        width: 20,
                                      )),
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                  hintText:
                                      "Enter Abbreviation of the Country ",
                                  fillColor: Colors.white70),
                            )),
                        new Padding(padding: EdgeInsets.only(top: 20)),
                        new Container(
                          height: 25,
                          width: 360,
                          child: new Text(
                            "Calling Codes: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        new Container(
                            width: 365,
                            child: new TextField(
                              controller: callingcodes,
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                        width: 20,
                                      )),
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                  hintText:
                                      "Enter Calling Codes of the Country ",
                                  fillColor: Colors.white70),
                            )),
                        new Padding(padding: EdgeInsets.only(top: 20)),
                        new Container(
                          height: 25,
                          width: 360,
                          child: new Text(
                            "Populations: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        new Container(
                            width: 365,
                            child: new TextField(
                              controller: population,
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                        width: 20,
                                      )),
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                  hintText:
                                      "Enter Number of Population of the Country ",
                                  fillColor: Colors.white70),
                            )),
                        new Padding(padding: EdgeInsets.only(top: 20)),
                        new Container(
                          height: 25,
                          width: 360,
                          child: new Text(
                            "Currencies: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        new Container(
                            width: 365,
                            child: new TextField(
                              controller: currencies,
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                        width: 20,
                                      )),
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                  hintText: "Enter Currency of the Country ",
                                  fillColor: Colors.white70),
                            )),
                        new Padding(padding: EdgeInsets.only(top: 20)),
                        new Container(
                          height: 25,
                          width: 360,
                          child: new Text(
                            "Languages: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        new Container(
                            width: 365,
                            child: new TextField(
                              controller: languages,
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                        width: 20,
                                      )),
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                  hintText: "Enter Languages of the Country ",
                                  fillColor: Colors.white70),
                            )),
                        new Padding(padding: EdgeInsets.only(top: 20)),
                        new Container(
                          height: 25,
                          width: 360,
                          child: new Text(
                            "Longitude: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        new Container(
                            width: 365,
                            child: new TextField(
                              controller: longitude,
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                        width: 20,
                                      )),
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                  hintText: "Enter Longitude of the Country ",
                                  fillColor: Colors.white70),
                            )),
                        new Padding(padding: EdgeInsets.only(top: 20)),
                        new Container(
                          height: 25,
                          width: 360,
                          child: new Text(
                            "Latitude: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        new Container(
                            width: 365,
                            child: new TextField(
                              controller: latitude,
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                        width: 20,
                                      )),
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                  hintText: "Enter Latitude of the Country ",
                                  fillColor: Colors.white70),
                            )),
                        new Padding(padding: EdgeInsets.only(top: 20)),
                        Center(
                          child: (image == null)
                              ? Text("Select an image",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: "Stocky",
                                  ))
                              : uploadArea(),
                        ),
                        new Padding(padding: EdgeInsets.only(top: 20)),
                        new Container(
                          width: 370,
                          height: 50,
                          child: RaisedButton(
                              color: Colors.white,
                              child: Text(" Gallery"),
                              onPressed: () {
                                getImage();
                              }),
                        ),
                        new Padding(padding: EdgeInsets.only(top: 20)),
                        new Container(
                          width: 370,
                          height: 50,
                          child: RaisedButton(
                              color: Colors.white,
                              child: Text("Add"),
                              onPressed: () {
                                addImage();
                                setState(() {
                                  message = "Done!";
                                });
                              }),
                        ),
                        new Padding(padding: EdgeInsets.only(top: 50)),
                        new Container(
                            child: Text(
                          message,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                              color: Colors.greenAccent),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
