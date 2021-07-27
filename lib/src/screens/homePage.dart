import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:open_weather/src/Navigation/navigation.dart';
import '../Colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController city = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
    city.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: backgroudColor,
      appBar: AppBar(
        title: Text("Weather Report"),
        leading: Image.asset("assets/logo.webp", height: 30.0, width: 30.0,),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.05,),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Enter any City name to show Weather Forecast",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: size.width * 0.95,
              padding: EdgeInsets.only(
                  top: size.height * 0.1, bottom: 10.0, left: 0.0, right: 0.0),
              child: TextField(
                controller: city,
                style: TextStyle(
                    fontSize: 20.0,
                    color: primaryColor,
                  fontWeight: FontWeight.bold
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterStyle: TextStyle(height: double.minPositive,),
                  counterText: "",
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: primaryColor,
                        width: 2
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(35.0)),
                  ),
                  prefixIcon: Icon(
                    Icons.location_city,
                    color: primaryColor,
                    size: 20.0,
                  ),
                  focusedBorder: new OutlineInputBorder(
                    borderSide: BorderSide(
                        color: primaryColor,
                        width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(35.0)),
                  ),
                  hintText: "City Name...",
                  hintStyle: TextStyle(
                      fontSize: 20.0, color: primaryColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: size.height * 0.2),
              child: MaterialButton(
                elevation: 5.0,
                onPressed: () {
                  if(city.text.isEmpty){
                    showInSnackBar("Please enter City Name");
                    return null;
                  }
                  Navigation.moveToWeatherScreen(context, city.text.trim());
                },
                color: primaryColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * .1,
                    vertical: size.width * .02,
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState!.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      duration: Duration(seconds: 2),
    ));
  }

}
