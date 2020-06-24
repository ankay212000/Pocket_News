import 'package:flutter/material.dart';

class ModalProgressHUD extends StatelessWidget {
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Offset offset;
  final bool dismissible;
  final Widget child;
  final String indicatorStatus;

  ModalProgressHUD({
    Key key,
    @required this.inAsyncCall,
    @required this.indicatorStatus,
    this.opacity = 0.3,
    this.color = Colors.grey,
//    this.progressIndicator = const ProgressIndicator(),
    this.offset,
    this.dismissible = false,
    @required this.child,
  })  : assert(child != null),
        assert(inAsyncCall != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (inAsyncCall) {
      Widget layOutProgressIndicator;
      if (offset == null)
        layOutProgressIndicator = Center(child: ProgressIndicator(indicatorStatus));
      else {
        layOutProgressIndicator = Positioned(
          child: ProgressIndicator(indicatorStatus),
          left: offset.dx,
          top: offset.dy,
        );
      }
      final modal = [
        new Opacity(
          child: new ModalBarrier(dismissible: dismissible, color: color),
          opacity: opacity,
        ),
        layOutProgressIndicator
      ];
      widgetList += modal;
    }
    return new Stack(
      children: widgetList,
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  final String indicatorStatus;

  ProgressIndicator(this.indicatorStatus);
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          height: deviceHeight * 0.15,
//          width: deviceHeight * 0.15,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                height: 10.0,
              ),
              Text(
                indicatorStatus,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
