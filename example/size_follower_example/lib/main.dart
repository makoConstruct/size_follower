import 'package:flutter/material.dart';
import 'package:size_follower/size_follower.dart';

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
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ValueNotifier<Size?> previousSize = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget withBorder(Widget child) {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 4, color: theme.colorScheme.onSurface),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(padding: EdgeInsets.all(3), child: child),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                withBorder(SizeReporter(
                    sizeListener: previousSize,
                    child: Container(
                      constraints: BoxConstraints(minWidth: 30),
                      child: IntrinsicWidth(
                          child: TextField(
                              decoration: InputDecoration(
                                  fillColor: theme.colorScheme.surfaceDim))),
                    ))),
                SizedBox(height: 3),
                withBorder(SizeFollower(
                    sizeListener: previousSize,
                    child: Container(
                        constraints: BoxConstraints.expand(),
                        decoration: BoxDecoration(color: Colors.black)))),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: SizeFollower(
                  sizeListener: previousSize,
                  child: Container(
                      constraints: BoxConstraints.expand(),
                      decoration: BoxDecoration(color: Colors.black)))),
        ],
      ),
    );
  }
}
