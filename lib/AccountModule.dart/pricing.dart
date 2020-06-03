import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nutshell/database.dart';
import 'package:nutshell/users.dart';

class Pricing extends StatefulWidget
{
  @override
  _PricingState createState() => _PricingState();
}

class _PricingState extends State<Pricing> {

    Users _currentUser = Users();

  Users get getCurrentUser => _currentUser;
bool isLoading=false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = "error";

    try {
      setState(() {
        isLoading=true;
      });
      FirebaseUser _firebaseUser = await _auth.currentUser();
      print(_firebaseUser.email);
      if (_firebaseUser != null) {
        print(_firebaseUser.uid);
        _currentUser = await OurDatabase().getUserInfo(_firebaseUser.uid);
        if (_currentUser != null) {
          retVal = "success";
          print("in if ");
          print(_currentUser.phone);
            setState(() {
        isLoading=false;
      });
        }
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onStartUp();
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pricing",style: TextStyle(color: Colors.black),),
          backgroundColor:Colors.orange[300],
          leading: new IconButton(
          icon: Icon(
                        Icons.arrow_back,
                        size: 30.0,
                        color: Colors.black,
                      ),
                      tooltip: 'back',
                      onPressed: () {
                        Navigator.pushNamed(context,"/account");
                    
          },
        ),
        ),
        body:WillPopScope(
          onWillPop: (){
            Navigator.pushNamed(context, '/account');
          },
        child:Column(
          children: <Widget>[

              SizedBox(
                height: 200,
                width: 200,
                child:Column(children: <Widget>[
                  // Text("Your Group is:"),
                  //  Text(_currentUser.group.toString())
                  Text("Will be added")
              
                ],)
              ),
              
            // Text("\n\n\n No Pricings till now",style: TextStyle(fontSize:SizeConfig.blockSizeVertical * 2.5,color: Colors.green),),
          ],
        ),
        ),
      )
    );
  }
}