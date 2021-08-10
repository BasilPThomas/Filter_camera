import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'dart:io' as platform;

class CameraScreenPage extends StatefulWidget {
  const CameraScreenPage({Key? key}) : super(key: key);

  @override
  _CameraScreenPageState createState() => _CameraScreenPageState();
}

class _CameraScreenPageState extends State<CameraScreenPage> {

  late CameraDeepArController cameraDeepArController;
  String platformVersion = "Unknown";
  int currentPage =0;
  final vp = PageController(viewportFraction: 0.24);
  Effects currentEffects = Effects.none;
  Effects currentFilters= Effects.none;
  Masks currentMask = Masks.none;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            CameraDeepAr(
              onCameraReady:(isReady){
                platformVersion ="Camera Status $isReady";
                print(platformVersion);
                setState(() {

                });
              },
                androidLicenceKey: "0fd19c8ac893811c0f8c613668ecbe79957f345e67204083f865e5ab0f3e880bcf11515c03552bad",
              cameraDeepArCallback: (c) async{
               cameraDeepArController =c;
               setState(() {

               });
              }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:MainAxisAlignment.end ,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(8, (page)
                          {
                            bool active =currentPage == page;
                            return GestureDetector(
                              onTap: (){
                                currentPage =page;
                                cameraDeepArController.changeMask(page);
                                setState(() {
                                });
                              },
                              child:AvatarView(
                                radius: active? 45 : 25 ,
                                borderColor: Colors.yellow,
                                borderWidth: 2,
                                isOnlyText: false,
                                avatarType: AvatarType.CIRCLE,
                                backgroundColor: Colors.red,
                                imagePath: "assets/android/${page.toString()}.jpg",
                                placeHolder: Icon(Icons.person,size:50),
                                errorWidget: Container(
                                  child: Icon(Icons.error,size:50),
                                ),
                              )
                            );
                          }),
                      ),
                    )
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

}
