import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import '../models/pharmacie.dart';
import '../models/global.dart';
import '../models/widg.dart';
import '../views/main1.dart';


class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();
  List data=[];
  List<Pharmacy> pharmacies=List<Pharmacy>();
  Set<Marker> markers=Set<Marker>();
  Future<List> getData() async{
    List<Pharmacy> tmpList=List<Pharmacy>();
    http.Response response = await http.get(
        Uri.encodeFull("http://10.0.2.2:5000/tanger/gards")
      );
      data = json.decode(response.body);

      for(int i=0;i<data.length;i++){
        Pharmacy p=new Pharmacy(vil: data[i]['TEL'],add: data[i]['ADD'],name:data[i]['NAME'],city:"Tanger",title: "LOOOOOOOl",phLogo: new AssetImage('image/1.png'));
        final String addr=p.name+" "+p.add+" Tanger"+" 9000";
        var addresses = await Geocoder.local.findAddressesFromQuery(addr);
        var first = addresses.first;
        p.lat=first.coordinates.latitude;
        p.long=first.coordinates.longitude;
        tmpList.add(p);
      }
      pharmacies=tmpList;
      for(Pharmacy p in pharmacies){
          Marker marker = Marker(
            markerId: MarkerId(p.name),
            position: LatLng(p.lat, p.long),
            infoWindow: InfoWindow(title: p.name),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueViolet,
            ),
          );
          markers.add(marker);
      }
    return data;
  }

  @override
  void initState() {
    super.initState();
  }
    double zoomVal=5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            }),
        title: Text("Tanger"),
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.search),
              onPressed: () {
                getData();
              }),
        ],
      ),
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _zoomminusfunction(),
          _zoomplusfunction(),
          FutureBuilder(
            future: getData(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.data!=null){
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  constraints: BoxConstraints.expand(height:200),
                  padding: EdgeInsets.only(top: 450, bottom: 50),
                  child: ListView(
                    padding: EdgeInsets.only(left: 20),
                    children: getPharmaciesInArea(),
                    scrollDirection: Axis.horizontal,
                  ),
                );
              }else
                return Container(
                    child:Center(
                      child: Text('loaaading'),
                    )
                );
            },
          )

        ],
      ),
    );
  }


 Widget _zoomminusfunction() {

    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
            icon: Icon(FontAwesomeIcons.searchMinus,color:Color(0xff6200ee)),
            onPressed: () {
              zoomVal--;
             _minus( zoomVal);
            }),
    );
 }
 Widget _zoomplusfunction() {
   
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
            icon: Icon(FontAwesomeIcons.searchPlus,color:Color(0xff6200ee)),
            onPressed: () {
              zoomVal++;
              _plus(zoomVal);
            }),
    );
 }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(35.76727, -5.79975), zoom: zoomVal)));
  }
  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(35.76727, -5.79975), zoom: zoomVal)));
  }


  Widget myDetailsContainer1(String restaurantName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(restaurantName,
            style: TextStyle(
                color: Color(0xff6200ee),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height:5.0),
        Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  child: Text(
                "4.1",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStarHalf,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
               Container(
                  child: Text(
                "(946)",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
            ],
          )),
          SizedBox(height:5.0),
        Container(
                  child: Text(
                "American \u00B7 \u0024\u0024 \u00B7 1.6 mi",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
              SizedBox(height:5.0),
        Container(
            child: Text(
          "Closed \u00B7 Opens 17:00 Thu",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:  CameraPosition(target: LatLng(35.788155499999995,-5.8151496), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(markers)

      ),
    );
  }

  List<Pharmacy> getPharmacies(){
    return pharmacies;
  }

  List<Widget> getPharmaciesInArea() {
    List<Pharmacy> pharamcies = getPharmacies();
    getData();
    List<Widget> cards = [];
    for (Pharmacy techy in pharamcies) {
      cards.add(pharmacyCard(techy));
    }
    return cards;
  }
  Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
  }
  Widget pharmacyCard(Pharmacy p) {
    return GestureDetector(
        onTap: () {
          _gotoLocation(p.lat,p.long);
        },

        child:Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(right: 20, bottom: 30, top: 30),
          height: 300,
          width: 300,
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
                    radius: 25,
                    backgroundColor:backgroundColor,
                    backgroundImage: p.phLogo,
                  ),
                  Text("  "+
                      p.name,
                    style: jobCardTitileStyleBlue,

                  )
                ],
              ),

              Text(p.add+" - ", style: jobCardTitileStyleBlack),
              Text("Tele: "+p.vil+"", style: jobCardTitileStyleBlack),

              Text("Tanger", style: salaryStyle)
            ],
          ),
        )
    );
  }

}

Marker gramercyMarker = Marker(
  markerId: MarkerId('gramercy'),
  position: LatLng(40.738380, -73.988426),
  infoWindow: InfoWindow(title: 'Gramercy Tavern'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);


List<Widget> getRatings(Pharmacy techy) {
  List<Widget> ratings = [];
  return ratings;
}