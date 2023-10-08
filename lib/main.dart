import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

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
        // the application has a blue toolbar. Then, without quitting the app,
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black45),
        scaffoldBackgroundColor: Colors.black87,

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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<Alignment> _animation;

  Alignment _dragAlignment = Alignment.center;



  /// Calculates and runs a [SpringSimulation].
  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );
    // Calculate the velocity relative to the unit interval, [0,1],
    // used by the animation controller.
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanDown: (details) {
        _controller.stop();
      },
      onPanUpdate: (details) {
        setState(() {
          _dragAlignment += Alignment(
            details.delta.dx / (size.width / 2),
            details.delta.dy / (size.height / 2),
          );
        });
      },
      onPanEnd: (details) {
        _runAnimation(details.velocity.pixelsPerSecond, size);
      },
      child: Align(
        alignment: _dragAlignment,
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          <Widget>[

            Container(
                height: 500,
                width: 300,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                        image: AssetImage('images/giphy (1).gif',),
                        fit: BoxFit.fill,
                        opacity: 150,
                      
                    )
                ),

                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            backgroundImage: AssetImage('images/profile.jpg'),
                            radius: 50
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'JOSHUA L. CHAN',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'GrandifloraOne',
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none
                          ),
                          textAlign: TextAlign.center,
                        ),

                      ],
                    ),
                    SizedBox(height: 7),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'LEAD GAME SOFTWARE DEVELOPER',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'GrandifloraOne',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none
                          ),
                          textAlign: TextAlign.center,
                        ),

                      ],
                    ),
                    SizedBox(height: 20),

                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      color: Colors.black45,

                      child: Column(

                        children: [
                          SizedBox(height: 10, width: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.call,
                                size: 24.0,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20, top: 1, bottom: 1),
                                child: Text(
                                  '09123456789',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'GrandifloraOne',
                                      fontSize: 16
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10, width: 40),
                        ],

                      ),


                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      color: Colors.black45,

                      child: Column(

                        children: [
                          SizedBox(height: 10, width: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on_sharp,
                                size: 24.0,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20, top: 1, bottom: 1),
                                child: Text(
                                  '09123456789',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'GrandifloraOne',
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10, width: 40),
                        ],
                      ),
                    )
                  ],
                )
            ),
          ],
        ),
      ),
    );

  }
}
