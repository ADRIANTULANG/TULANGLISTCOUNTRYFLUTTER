import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'addcountry.dart';
// import 'stream.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'List Of Countries'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final search = TextEditingController();
  List<Posted> posts = List();
  List<Posted> filteredUsers = List();

  Future<List<Posted>> getdatacountries() async {
    try {
      http.Response response = await http.get(
          "https://adrianlistcountries.000webhostapp.com/getdatacountries.php");
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new Posted.fromJson(m)).toList();
    } catch (e) {
      http.Response response = await http.get(
          "https://adrianlistcountries.000webhostapp.com/getdatacountries.php");
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new Posted.fromJson(m)).toList();
    }
  }

  @override
  void initState() {
    super.initState();

    getdatacountries().then((usersFromServer) {
      setState(() {
        posts = usersFromServer;
        filteredUsers = posts;
      });
    });
  }

  refresh() {
    getdatacountries().then((usersFromServer) {
      setState(() {
        posts = usersFromServer;
        filteredUsers = posts;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddCountry()));
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            new TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  hintText: " Search Country"),
              controller: search,
              onChanged: (string) {
                setState(() {
                  filteredUsers = posts
                      .where((u) => (u.countryname
                              .toLowerCase()
                              .contains(string.toLowerCase()) ||
                          u.abbv.toLowerCase().contains(string.toLowerCase())))
                      .toList();
                });
              },
            ),
            new Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: filteredUsers.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      color: Colors.white30,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                height: 750,
                                width: 400,
                                child: Column(
                                  children: <Widget>[
                                    new Padding(
                                        padding: EdgeInsets.only(top: 20)),
                                    new Column(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          height: 200,
                                          width: 300,
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            image: new DecorationImage(
                                                image: new NetworkImage(
                                                    filteredUsers[index]
                                                        .flagurl),
                                                fit: BoxFit.cover),
                                            border: new Border.all(
                                              color: Colors.black,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        new Padding(
                                            padding: EdgeInsets.only(top: 30)),
                                      ],
                                    ),
                                    new Container(
                                        width: 300,
                                        height: 50,
                                        child: Row(
                                          children: <Widget>[
                                            new Container(
                                              child: new Text(
                                                "Country Name: ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(),
                                              ),
                                            ),
                                            new Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10)),
                                            new Container(
                                              child: new Text(
                                                "     " +
                                                    filteredUsers[index]
                                                        .countryname,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    new Container(
                                        width: 300,
                                        height: 30,
                                        child: Row(
                                          children: <Widget>[
                                            new Container(
                                              child: new Text(
                                                "Capital: ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(),
                                              ),
                                            ),
                                            new Padding(
                                                padding:
                                                    EdgeInsets.only(left: 57)),
                                            new Container(
                                              child: new Text(
                                                "     " +
                                                    filteredUsers[index]
                                                        .capital,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    new Container(
                                        width: 300,
                                        height: 50,
                                        child: Row(
                                          children: <Widget>[
                                            new Container(
                                              child: new Text(
                                                "Region: ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(),
                                              ),
                                            ),
                                            new Padding(
                                                padding:
                                                    EdgeInsets.only(left: 60)),
                                            new Container(
                                              child: new Text(
                                                "     " +
                                                    filteredUsers[index].region,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    new Container(
                                        width: 300,
                                        height: 50,
                                        child: Row(
                                          children: <Widget>[
                                            new Container(
                                              child: new Text(
                                                "Abbreviations: ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(),
                                              ),
                                            ),
                                            new Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20)),
                                            new Container(
                                              child: new Text(
                                                "     " +
                                                    filteredUsers[index].abbv,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    new Container(
                                        width: 300,
                                        height: 50,
                                        child: Row(
                                          children: <Widget>[
                                            new Container(
                                              child: new Text(
                                                "Calling Codes: ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(),
                                              ),
                                            ),
                                            new Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20)),
                                            new Container(
                                              child: new Text(
                                                "     " +
                                                    filteredUsers[index]
                                                        .callingcodes,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    new Container(
                                        width: 300,
                                        height: 50,
                                        child: Row(
                                          children: <Widget>[
                                            new Container(
                                              child: new Text(
                                                "Population: ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(),
                                              ),
                                            ),
                                            new Padding(
                                                padding:
                                                    EdgeInsets.only(left: 40)),
                                            new Container(
                                              child: new Text(
                                                "     " +
                                                    filteredUsers[index]
                                                        .population,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    new Container(
                                        width: 300,
                                        height: 50,
                                        child: Row(
                                          children: <Widget>[
                                            new Container(
                                              child: new Text(
                                                "Currencies: ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(),
                                              ),
                                            ),
                                            new Padding(
                                                padding:
                                                    EdgeInsets.only(left: 40)),
                                            new Container(
                                              child: new Text(
                                                "     " +
                                                    filteredUsers[index]
                                                        .currencies,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    new Container(
                                        width: 300,
                                        height: 50,
                                        child: Row(
                                          children: <Widget>[
                                            new Container(
                                              child: new Text(
                                                "Languages: ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(),
                                              ),
                                            ),
                                            new Padding(
                                                padding:
                                                    EdgeInsets.only(left: 40)),
                                            new Container(
                                              child: new Text(
                                                "     " +
                                                    filteredUsers[index]
                                                        .languages,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    new Container(
                                        width: 300,
                                        height: 50,
                                        child: Row(
                                          children: <Widget>[
                                            new Container(
                                              child: new Text(
                                                "Longitude: ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(),
                                              ),
                                            ),
                                            new Padding(
                                                padding:
                                                    EdgeInsets.only(left: 45)),
                                            new Container(
                                              child: new Text(
                                                "     " +
                                                    filteredUsers[index]
                                                        .longitude,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    new Container(
                                        width: 300,
                                        height: 50,
                                        child: Row(
                                          children: <Widget>[
                                            new Container(
                                              child: new Text(
                                                "Latitude: ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(),
                                              ),
                                            ),
                                            new Padding(
                                                padding:
                                                    EdgeInsets.only(left: 60)),
                                            new Container(
                                              child: new Text(
                                                "     " +
                                                    filteredUsers[index]
                                                        .latitude,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.refresh),
        backgroundColor: Colors.black,
        onPressed: () {
          refresh();
          setState(() {});
        },
      ),
    );
  }
}

class Posted {
  final int countryid;
  final String countryname;
  final String capital;
  final String region;
  final String abbv;
  final String callingcodes;
  final String population;
  final String currencies;
  final String languages;
  final String longitude;
  final String latitude;
  final String flagurl;

  Posted({
    this.countryid,
    this.countryname,
    this.capital,
    this.region,
    this.abbv,
    this.callingcodes,
    this.population,
    this.currencies,
    this.languages,
    this.longitude,
    this.latitude,
    this.flagurl,
  });

  factory Posted.fromJson(Map<String, dynamic> json) {
    return new Posted(
      population: json['population'].toString(),
      countryname: json['countryname'].toString(),
      capital: json['capital'].toString(),
      region: json['region'].toString(),
      abbv: json['abbv'].toString(),
      callingcodes: json['callingcodes'].toString(),
      languages: json['languages'].toString(),
      currencies: json['currencies'].toString(),
      longitude: json['longitude'].toString(),
      latitude: json['latitude'].toString(),
      flagurl: json['flagurl'].toString(),
    );
  }
}
