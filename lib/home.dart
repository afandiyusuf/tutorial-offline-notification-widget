import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:open_settings/open_settings.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var subscription;
  bool isVisible = false;
  @override
  void initState() {
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
        isVisible = false;
      } else{
        isVisible = true;
      }
       setState(() {
         isVisible = isVisible;
       });
      print("terjadi perubahan $result");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.blue,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Visibility(
            visible: isVisible,
            child: Positioned(
                bottom: 0,
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/4,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text("Oops, sepertinya kamu sedang offline"),
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                                child: Text("Open Wifi"),
                                onPressed: (){
                                  OpenSettings.openWIFISetting();
                                }),
                            MaterialButton(
                                child: Text("Open Data Connection"),
                                onPressed: (){
                                  OpenSettings.openDataUsageSetting();
                                }),
                          ],
                        )

                      ],
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
