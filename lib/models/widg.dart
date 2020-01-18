import 'package:flutter/material.dart';

import 'global.dart';
import 'Person.dart';
class widgBox{
  String str;
  String nom0="Nouhaila Essahih",nom1="Chbab Khalid",nom2="Khallouk Achraf";

/*List<Widget> getGardes() {
  List<Widget> gardeCards = [];
  List<Pharmacie> pharmaciess = pharmacieGarde();
  for (Pharmacie ph in pharmaciess) {
    gardeCards.add(getPhCard(ph));
  }
  return gardeCards;
}


List<Pharmacie> pharmacieGarde() {
  List<Pharmacie> phars = [];
  for (int i = 0; i < 10; i++) {
    phars.add(new Pharmacie("Tnagier", "Pharmacie de garde", 20000, "Address", "Name", new AssetImage("image/1.png")));
  }
  return phars;
}
List<Person> developpers(){


}

Widget getPhCard(Pharmacie phar) {
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

              radius: 30,
              backgroundColor:backgroundColor,
              backgroundImage: phar.phLogo,

            ),
            Text("  "+
              phar.city,
              style: jobCardTitileStyleBlue,

            )
          ],
        ),

        Text(phar.title + " - " + phar.timeRequirement, style: jobCardTitileStyleBlack),
        Text(phar.location),
        Text("22", style: salaryStyle)
      ],
    ),
  );
}
}*/
  List<Widget> getDevs() {
    List<Widget> devCards = [];
    List<Person> devs = developpers();
    for (Person ph in devs) {
      devCards.add(getDevCard(ph));
    }
    return devCards;
  }


  List<Person> developpers(){
    List<Person> phars = [];
    for (int i = 0; i < 3; i++) {

      phars.add(new Person((i==0)?nom0:(i==1)?nom1:nom2, "FSTT Master Student", 22, "",  new AssetImage(getImg(i))));
    }
    return phars;

  }

  Widget getDevCard(Person phar) {
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

                radius: 30,
                backgroundColor:backgroundColor,
                backgroundImage: phar.phLogo,

              ),
              Text("  "+
                  phar.name,
                style: jobCardTitileStyleBlue,

              )
            ],
          ),

          Text(phar.title + " - " , style: jobCardTitileStyleBlack),
          Text(phar.description),
          Text("22", style: salaryStyle)
        ],
      ),
    );
  }
  String getImg(int i){
    String a=(i==0)?("image/4.jpg"):(i==1)?("image/7.jpg"):("image/9.jpg");
    return a;


  }
}

