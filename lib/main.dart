import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try~
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  static const MethodChannel platform = MethodChannel('Example');
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = MethodChannel('sample.example');
  String _result = 'Waiting ...';
  bool _showText = false;

  Future<void> _getVersionFromNative() async {
    try {
      final String data = await platform.invokeMethod('getVersion');
      _result = data;
    } on PlatformException catch (e) {
      _result = 'Fail to get version: ${e.message}';
    }
    _showText = !_showText;
    _showText
        ? setState(
            () => _result = _result,
          )
        : setState(() => _result = 'Nothing here');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Call native code '),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _result,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getVersionFromNative,
        tooltip: 'Get OS Version',
        child: const Icon(Icons.change_history),
      ),
    );
  }
}
