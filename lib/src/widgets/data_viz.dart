import 'package:flutter/material.dart';
import '../Colors.dart';
import 'circle/neuomorphic_circle.dart';
import 'progress_ring.dart';

class DataViz extends StatelessWidget {
  final bevel = 10.0;
  final blurOffset = Offset(20.0 / 2, 20.0 / 2);

  Color shadowColor = Colors.black54;
  Color backgroundColor = Colors.white;
  Color highlightColor = Colors.white.withOpacity(0.05);
  final String value, keyValue;
  final Color color;
  DataViz(this.value, this.color, this.keyValue);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
          aspectRatio: 1,
          child: Stack(
            alignment: Alignment.center,
            children: [
              NeuomorphicCircle(
                shadowColor: shadowColor,
                backgroundColor: backgroundColor,
                highlightColor: highlightColor,
                innerShadow: true,
                outerShadow: false, child: SizedBox(),
              ),
              LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      width: constraints.maxWidth * 0.3,
                      height: constraints.maxWidth * 0.3,
                      child: NeuomorphicCircle(
                        innerShadow: false,
                        outerShadow: true,
                        highlightColor: highlightColor,
                        shadowColor: shadowColor,
                        backgroundColor: backgroundColor,
                        child: SizedBox.expand(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                value,
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              ),
              ProgressRing(color, progress: calc(value))
            ],
          )),
    );
  }

  double calc(String value) {
    int div = 0;
    double current = double.parse(value);

    if(keyValue == "s") div = 1000;
    if(keyValue == "d") div = 360;

    print("${current / div}");

    return current / div;
  }
}
