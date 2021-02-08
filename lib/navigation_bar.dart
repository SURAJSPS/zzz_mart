import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double yTransValue = 0;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        print(notification.metrics.axisDirection);
        print(notification.metrics.axis);

        if (notification.scrollDelta.sign == 1) {
          setState(() {
            yTransValue = 100;
          });
        } else if (notification.scrollDelta.sign == -1) {
          setState(() {
            yTransValue = 0;
          });
        }
        return;
      },
      child: Scaffold(
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 260,
              child: Card(
                child: Center(child: Text('Item #$index')),
              ),
            );
          },
        ),
        bottomNavigationBar: AnimatedContainer(
          duration: Duration(milliseconds: 600),
          transform: Matrix4.translationValues(0, yTransValue, 0),
          child: SizedBox(
            height: 60,
            child: Card(
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.home),
                  Icon(Icons.search),
                  Icon(Icons.favorite_border),
                  Icon(Icons.person_rounded),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
