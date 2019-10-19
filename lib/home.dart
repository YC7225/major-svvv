import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:tod/inference.dart';
import 'package:tod/login.dart';

import 'auth.dart';

class Home extends StatelessWidget {
  final String email;
  final String uid;
  final String displayName;
  final String photoUrl;
  final List<CameraDescription> cameras;

  const Home({
    this.email,
    this.uid,
    this.displayName,
    this.photoUrl,
    this.cameras,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('TOD'),
        centerTitle: true,
        actions: <Widget>[
          CircleAvatar(
            radius: 15,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: photoUrl == null
                  ? Image.asset(
                      'assets/profile-image.png',
                      fit: BoxFit.fill,
                    )
                  : NetworkImage(photoUrl),
            ),
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              Auth auth = Auth();
              await auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(
                    cameras: cameras,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Welcome Text
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                'Welcome\n$displayName',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
            ),

            // Object Detection Button
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ButtonTheme(
                minWidth: 200,
                height: 60,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: FlatButton(
                  color: Colors.green,
                  child: Text(
                    'Object Detection',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => _onObjectSelect(context),
                ),
              ),
            ),

            // Cancer Detection Button
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ButtonTheme(
                minWidth: 200,
                height: 60,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: FlatButton(
                  color: Colors.blue,
                  child: Text(
                    'Cancer Detection',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => _onCancerSelect(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onObjectSelect(BuildContext context) async {
    // String res = await Tflite.loadModel(
    //   model: "assets/model.tflite",
    //   labels: "assets/labels.txt",
    // );
    // print('Model Response:' + res);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InferencePage(
          cameras: cameras,
          title: 'Object Detection',
          model: "assets/yolov2_tiny.tflite",
          labels: "assets/labels.txt",
        ),
      ),
    );
  }

  void _onCancerSelect(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Coming Soon!"),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
