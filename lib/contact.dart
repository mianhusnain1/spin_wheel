import 'package:flutter/material.dart';
import 'package:wheel_of_names/constant.dart';

class SpinWheel extends StatefulWidget {
  const SpinWheel({super.key});

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: mq.height * 0.1,
            ),
            Container(
              height: mq.height * 0.1,
              width: mq.width * 0.95,
              decoration: BoxDecoration(
                color: AppColors.darkColor,
                borderRadius: BorderRadius.circular(30),
              ),
            )
          ],
        ),
      ),
    );
  }
}
