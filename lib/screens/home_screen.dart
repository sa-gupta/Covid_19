import 'package:covid_19/constants.dart';
import 'package:covid_19/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
//import 'package:covid_19/cases.dart';


class HomeScreen extends StatefulWidget {
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Map data;
  var userData ;
 
 int newConCase;
 int totDeathCase;
 int totRecoveredCase;
 int totConfirmedCase;


  Future getData() async{
    http.Response response = await http.get("https://api.covid19api.com/summary");
    data = json.decode(response.body);

    setState(() {
      userData = data["Global"];
    });
    totConfirmedCase= userData['TotalConfirmed'];
    totDeathCase = userData['TotalDeaths'];
    totRecoveredCase= userData['TotalRecovered'];
    newConCase = userData['NewConfirmed'];
    

  }

  @override
  void initState() {
    super.initState();
    getData();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      drawer: buildDrawer(context),
      appBar: buildAppBar(),
      body: SingleChildScrollView(
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Container(
              padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 40),
              width: double.infinity,
              decoration: BoxDecoration(
                color: cPrimaryColor.withOpacity(0.03),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Wrap(
                runSpacing: 20,
                spacing: 20,
                children: <Widget>[
                  InfoCard(
                    title: "Confirmed Cases",
                    iconColor: Color(0xFFFF8C00),
                    effectedNum: totConfirmedCase
                  ),
                  InfoCard(
                    title: "Total Deaths",
                    iconColor: Color(0xFFFF2D55),
                    effectedNum: totDeathCase,
                  ),
                  InfoCard(
                    title: "Total Recovered",
                    iconColor: Color(0xFF50E3C2),
                    effectedNum: totRecoveredCase,
                  ),
                  InfoCard(
                    title: "New Cases",
                    iconColor: Color(0xFF5856D6),
                    effectedNum: newConCase,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Prevention", 
                    style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(
                      fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      PreventionCard(
                        svgSrc: "assets/icons/hand_wash.svg",
                        text: "Waash Hands"
                      ),
                      PreventionCard(
                        svgSrc: "assets/icons/use_mask.svg",
                        text: "Use Mask"
                      ),
                      PreventionCard(
                        svgSrc: "assets/icons/Clean_Disinfect.svg",
                        text: "Clean Disinfect",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 170,
                    width: double.infinity,
                    
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .4,
                              top: 20,
                              right: 20
                              ),
                            height: 130,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFF9ADD4),
                                  Color(0xFFFF5D8F),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          child: RichText(text: TextSpan(
                          children: [
                          
                          TextSpan(text: "Dial 999 for \nMedical Help!", style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(
                            color: Colors.white),
                            ),
                            TextSpan(
                              text: "\nIf any symptoms appear",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                          ),
                          
                          
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            height: 150,
                            width: double.infinity,
                            child: SvgPicture.asset("assets/icons/nurse.svg"),
                            
                          ),
                        ),
                        Positioned(
                          top: 30,
                          right: 10,
                          child: SvgPicture.asset("assets/icons/virus.svg"),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    
    return AppBar(
      backgroundColor: cPrimaryColor.withOpacity(0.03),
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"), 
          onPressed: () {},
          ),
        ],
    );
  }
}

  Drawer buildDrawer(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: cPrimaryColor.withOpacity(0.05),
            ),
            child: Text(
              "Header"
              ),
            ),
            ListTile(
              title: Text("Home"),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
    );
  }

class PreventionCard extends StatelessWidget {
  final String svgSrc;
  final String text;
  const PreventionCard({
    Key key, 
    this.svgSrc, 
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
          SvgPicture.asset(svgSrc,
          height: 50,
          width: 50,
          ),
          SizedBox(
            height: 10,
          ),
          Text(text,
          style: Theme.of(context)
          .textTheme
          .bodyText1
          .copyWith(
            color: cPrimaryColor
            ),
          ),
      ],
    );
  }
}










