import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_i_see_u/modules/timer/components/custom_time_painter.dart';
import 'package:flutter_i_see_u/modules/timer/controller_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CounterComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320.w,
      height: 112.h,
      child: Card(
          color: Colors.black54.withOpacity(0.35),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: _buildCounterRing()),
    );
  }

  Widget _buildCounterRing() {
    var timeController = TimerController.to.animationController!;
    return AnimatedBuilder(
        animation: timeController,
        builder: (context, builder) {
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Align(
                      alignment: FractionalOffset.center,
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: CustomPaint(
                                painter: CustomTimerPainter(
                                    animation: timeController,
                                    backgroundColor: Colors.white,
                                    color: Colors.yellow),
                              ),
                            ),
                            Align(
                              alignment: FractionalOffset.center,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Count Down Timer",
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                  AnimatedBuilder(
                                      animation: timeController,
                                      builder: (context, child) {
                                        return Text(
                                          TimerController.to.timerString,
                                          style: TextStyle(
                                              fontSize: 112.0,
                                              color: Colors.white),
                                        );
                                      }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                    AnimatedBuilder(
                        animation: timeController,
                        builder: (context, child) {
                          return FloatingActionButton.extended(
                              onPressed: () {
                                if (timeController.isAnimating)
                                  timeController.stop();
                                else {
                                  timeController.reverse(
                                      from: timeController.value == 0.0
                                          ? 1.0
                                          : timeController.value);
                                }
                              },
                              icon: Icon(timeController.isAnimating
                                  ? Icons.pause
                                  : Icons.play_arrow),
                              label: Text(timeController.isAnimating
                                  ? "Pause"
                                  : "Play"));
                        }),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
