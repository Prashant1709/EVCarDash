import 'package:car_dashbord/dashboard.dart';
import 'package:car_dashbord/mapping.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'components/time_and_temp.dart';
import 'dart:math';
import 'dart:async';
class Startup extends StatefulWidget {
  const Startup({super.key});

  @override
  State<Startup> createState() => _StartupState();
}

class _StartupState extends State<Startup> {
  bool isCarStarted=false;
  List<double> speedLineOpacities = [1, 0.8, 0.6, 0.4, 0.3, 0.2, 0.15, 0.1];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: double.infinity,
        child: (size.width > 1184 && size.height > 604)
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(16),
              constraints: const BoxConstraints(
                minWidth: 1184,
                maxWidth: 1480,
                minHeight: 456,
                maxHeight: 604,
              ),
              child: AspectRatio(
                aspectRatio: 2.59,
                child: LayoutBuilder(
                  builder: (context, constraints) => CustomPaint(
                    painter: PathPainter(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TimeAndTemp(constraints: constraints),
                        Expanded(
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ...List.generate(
                                speedLineOpacities.length,
                                    (index) => Positioned(
                                  bottom: 20 + (2 * index).toDouble(),
                                  left: constraints.maxWidth * 0.13 -
                                      (30 * index),
                                  height: constraints.maxHeight * 0.8,
                                  width: constraints.maxWidth * 0.31,
                                  child: Opacity(
                                    opacity: speedLineOpacities[index],
                                    child: CustomPaint(
                                      painter: SpeedLinePainter(),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(left: MediaQuery.of(context).size.width*0.451,top: MediaQuery.of(context).size.height*0.1,
                                child: ClipOval(
                                  child: ElevatedButton(
                                    onPressed: (){
                                      setState(() {
                                        // Toggle car start state
                                        isCarStarted = false;
                                      });
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        // Toggle car start state
                                        isCarStarted = true;
                                        Navigator.push(context, MaterialPageRoute(builder:(BuildContext bs)=>Mapping()));
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(100, 150),
                                      primary: isCarStarted ? Colors.greenAccent : Color(0xff6B4339).withOpacity(1),
                                    ),
                                    child: Text(isCarStarted ? 'Stop EV' : 'Start EV'),
                                  ),
                                ),),
                              ...List.generate(
                                speedLineOpacities.length,
                                    (index) => Positioned(
                                  bottom: 20 + (2 * index).toDouble(),
                                  right: constraints.maxWidth * 0.13 -
                                      (30 * index),
                                  height: constraints.maxHeight * 0.8,
                                  width: constraints.maxWidth * 0.31,
                                  child: Transform.scale(
                                    scaleX: -1,
                                    child: Opacity(
                                      opacity: speedLineOpacities[index],
                                      child: CustomPaint(
                                        painter: SpeedLinePainter(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(visible: isCarStarted,
                                child: Positioned(left: MediaQuery.of(context).size.width*0.41,top: MediaQuery.of(context).size.height*0.5,
                                  child: Text("Hi! Welcome Aboard",style: TextStyle(fontSize: 22,color:Color(0xff6B4339).withOpacity(1) ),)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
            : Center(
          child: Text(
              "The screen is too small to display the UI \n It can't be viewed on a phone. Try resizing your browser if you are on the web."),
        ),
      ),
    );
  }
}
class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
    // ..color = Colors.red
      ..shader = const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.bottomRight,
        // end: a,
        colors: [
          Color(0xFF6B4339),
          Color(0xFF52342C),
        ],
      ).createShader(const Offset(0, 0) & size)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    // paint.shader = LinearGradient(colors: colors)

    Path path = Path();
    path.moveTo(0, size.height / 2);
    path.lineTo(size.width * 0.13, size.height * 0.05);
    path.lineTo(size.width * 0.31, 0);
    path.lineTo(size.width * 0.39, size.height * 0.11);
    path.lineTo(size.width * 0.60, size.height * 0.11);
    path.lineTo(size.width * 0.69, 0);
    path.lineTo(size.width * 0.87, size.height * 0.05);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width * 0.87, size.height);
    path.lineTo(size.width * 0.13, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
class SpeedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double stockWidth = 8;
    Path path_0 = Path()
      ..moveTo(size.width * 0.76, 0)
      ..lineTo(size.width, size.height * 0.30)
      ..lineTo(size.width - stockWidth, size.height * 0.30)
      ..close();

    Path path1 = Path()
      ..moveTo(size.width, size.height * 0.30)
      ..lineTo(40, size.height - 20)
      ..lineTo(size.width - stockWidth, size.height * 0.30)
      ..close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.9125874, size.height * -0.000008129217),
        Offset(size.width * 0.8369860, size.height * 1.762893), [
      const Color(0xff6B4339).withOpacity(1),
      const Color(0xff7D7472).withOpacity(0.79)
    ], [
      0,
      1
    ]);
    canvas.drawPath(path_0, paint0Fill);
    canvas.drawPath(path1, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}