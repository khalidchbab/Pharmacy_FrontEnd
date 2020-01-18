import 'dart:async';
import 'dart:convert';
import 'global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CityList extends StatefulWidget {
  String city;
  CityList({this.city});
  @override
  CityListState createState() => CityListState();
}

class CityListState extends State<CityList> {
  String city;
  CityListState({this.city});
  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("http://10.0.2.2:5000/tanger/pharmacies"),
        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(() {
      data = json.decode(response.body);
    });
    print(data[0]["ADD"]);

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(city),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child:Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(right: 1, bottom: 1, top: 1),
              height: 150,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey,
                      blurRadius: 20.0,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
            child : Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(

                  children: <Widget>[
                    CircleAvatar(

                      radius: 30,
                      backgroundColor:backgroundColor,
                      backgroundImage: new AssetImage('image/1.png'),
                    ),
                    Text("  "+
                        data[index]["NAME"],style: jobCardTitileStyleBlue2,
                    ),

                  ],
                ),
                Center(
                  child:Text(data[index]["ADD"], style: jobCardTitileStyleBlack2),
                ),
                Text(data[index]["VIL"], style: salaryStyle),

              ]
            )
            ));
        },
      ),
    );
  }
}