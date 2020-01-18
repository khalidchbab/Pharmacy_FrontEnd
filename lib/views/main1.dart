
import 'package:flutter/material.dart';
import 'package:fluttergooglemapsapp/views/homepage.dart';
import '../models/Pharmacie2.dart';
import '../models/global.dart';
import '../models/widg.dart';
import '../models/CityList.dart';
import '../views/homepage.dart';

class MyApp1 extends StatelessWidget {
  widgBox wdg =new widgBox(); //this is just to open a function in widg file
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('First Route'),
      ),
      body:
        Center(
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            Center(
              child: Container(
                height: 200,
                width: 200,
                child : Image.asset('image/1.png')
              ),
            ),
              Center(
                child: Container(

                  child:

                  RaisedButton(
                  color: Colors.cyanAccent,

                    child:


                    Text('Check Pharmacies'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Pharmacies()),
                      );
                    },),
                ),
              ),
              Container(
            margin: EdgeInsets.only(bottom: 20),
            constraints: BoxConstraints.expand(height:200),
               child: ListView(
               padding: EdgeInsets.only(left: 40),
               scrollDirection: Axis.horizontal,
               children: wdg.getDevs()
                ),
                ),


            ],
          ),
        ),


    );
  }
}

class Pharmacies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pharmacie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }

}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor,
        child:
        ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(40),
                  constraints: BoxConstraints.expand(height: 225),
                  decoration: BoxDecoration(
                      gradient: new LinearGradient(
                          colors: [lightBlueIsh, lightGreen],
                          begin: const FractionalOffset(1.0, 1.0),
                          end: const FractionalOffset(0.2, 0.2),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp
                      ),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight:  Radius.circular(30))
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Find a Pharmacy', style: titleStyleWhite,)
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 120),
                  constraints: BoxConstraints.expand(height:200),
                  child: ListView(
                      padding: EdgeInsets.only(left: 40),
                      scrollDirection: Axis.horizontal,
                      children: getGardes()
                  ),
                ),
                Container(
                  height: 500,
                  margin: EdgeInsets.only(top: 300),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom:5.0),
                        child: Text(
                          "Menu",
                          style: titileStyleBlack,
                        ),
                      ),

                      Container(
                        height: 400,
                        child: ListView(
                          children: getOptions(),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  List<String> pharmacieOptions = ["Pharmacies", "Garde", "About_US", "Donate","Report"];

  Map optionIcon = {
    "Donate" : Icon(Icons.monetization_on, color: lightBlueIsh, size: 50,),
   "Report" : Icon(Icons.settings, color: lightBlueIsh, size: 50),
    "Garde" : Icon(Icons.healing, color: lightBlueIsh, size: 50),
    "Pharmacies" : Icon(Icons.search, color: lightBlueIsh, size: 50),
    "About_US" : Icon(Icons.android, color: lightBlueIsh, size: 50),
  };

  Widget getCategoryContainer(String categoryName) {
  //  String sa=""
    //int i=1;
    return new Container(
      margin: EdgeInsets.only(right: 10, left: 10, bottom: 20),
      height: 180,
      width: 140,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          new BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Text(categoryName, style: titileStyleLighterBlack),
          Container(
            padding: EdgeInsets.only(top: 30),
            height: 100,
            width: 70,

            child: FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.white,
              child:  optionIcon[categoryName],
              elevation: 10,
              onPressed: () { {
                if(categoryName=="Pharmacies")
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp1()),
                );
                if(categoryName=="Garde")
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
             } },
            ),
          )
        ],
      ),
    );
  }

  List<Widget> getOptions() {
    List<Widget> phCategoriesCards = [];
    List<Widget> rows = [];
    int i = 0;
    for (String category in pharmacieOptions) {
      if (i < 2) {
        rows.add(getCategoryContainer(category));
        i ++;
      } else {
        i = 0;
        phCategoriesCards.add(new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rows,
        ));
        rows = [];
        rows.add(getCategoryContainer(category));
        i++;
      }
    }
    if (rows.length > 0) {
      phCategoriesCards.add(new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rows,
      ));
    }
    return phCategoriesCards;
  }

  List<Pharmacie2> pharmacieGarde() {
    List<Pharmacie2> phars = [];
    for (int i = 0; i < 10; i++) {
      phars.add(new Pharmacie2("Tangier", "Pharmacie de garde", 20000, "Address", "Name", new AssetImage("image/1.png")));
    }
    return phars;
  }
//mabghitx nmsa7 had function wsf 7abitha fiha lflluss
  String makeSalaryToK(double salary) {
    String money = "";
    if (salary > 1000) {
      if (salary > 100000000) {
        salary = salary/100000000;
        money = salary.toInt().toString() + "M";
      } else {
        salary = salary/1000;
        money = salary.toInt().toString() + "K";
      }
    } else {
      money = salary.toInt().toString();
    }
    return "\$" + money;
  }

  List<Widget> getGardes() {
    List<Widget> gardeCards = [];
    List<Pharmacie2> pharmaciess = pharmacieGarde();
    for (Pharmacie2 ph in pharmaciess) {
      gardeCards.add(getPhCard(ph));
    }
    return gardeCards;
  }

  Widget getPhCard(Pharmacie2 phar) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 20, bottom: 30, top: 30),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundColor:backgroundColor,
                backgroundImage: phar.phLogo,
              ),
              Text(
                phar.city,
                style: jobCardTitileStyleBlue,
              )
            ],
          ),
          Text(phar.title + " - " + phar.timeRequirement, style: jobCardTitileStyleBlack),
          Text(phar.location),
          Text(makeSalaryToK(phar.salary), style: salaryStyle)
        ],
      ),
    );
  }
}