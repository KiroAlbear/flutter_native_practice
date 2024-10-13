import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _userName = "";
  MethodChannel messagesChannel = MethodChannel("messagesChannel");
  MethodChannel activitiesChannel = MethodChannel("activitiesChannel");

  String sendMessageToAndroidMethod = "sendMessageToAndroidMethod";
  String receiveMessageToAndroidMethod = "receiveMessageToAndroidMethod";

  String openAndroidActivityMethod = "openAndroidActivityMethod";

  void _sendMessageToAndroid() {
    messagesChannel.invokeMethod(
        sendMessageToAndroidMethod, {"message": "Hello from Flutter"});
  }

  void _recieveMessageFromAndroid() {
    messagesChannel.invokeMethod(receiveMessageToAndroidMethod).then(
      (dynamic value) {
        Map<Object?, Object?> message = value as Map<Object?, Object?>;

        Fluttertoast.showToast(
          msg: value["message"]! as String,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
    );
  }

  void _openAndroidActivity() {
    activitiesChannel.invokeMethod(openAndroidActivityMethod).then(
      (value) {
        setState(() {
          _userName = value as String;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_userName',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
                onPressed: _sendMessageToAndroid,
                child: Text("message to android")),
            ElevatedButton(
                onPressed: _recieveMessageFromAndroid,
                child: Text("message from android")),
            ElevatedButton(
                onPressed: _openAndroidActivity,
                child: Text("open android activity")),
          ],
        ),
      ),
    );
  }
}
