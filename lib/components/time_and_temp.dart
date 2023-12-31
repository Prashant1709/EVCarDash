import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TimeAndTemp extends StatelessWidget {
  const TimeAndTemp({
    Key? key,
    required this.constraints,
  }) : super(key: key);

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: constraints.maxWidth * 0.21,
      height: constraints.maxHeight * 0.11,
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.titleMedium!,
        child: Row(
          children: [
            Text("${DateTime.now().hour}:${DateTime.now().minute}"),
            const Spacer(),
            SvgPicture.asset(
              "assets/icons/sun.svg",
              height: 32,
            ),
            const SizedBox(width: 4),
            Text("25 °C"),
          ],
        ),
      ),
    );
  }
}
