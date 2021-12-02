import 'package:flutter/material.dart';

class DismissibleCardWidget extends StatelessWidget {
  final String keyValue;
  final Widget child;
  final void Function()? onDismissToLeft;
  final void Function()? onDismissToRight;

  const DismissibleCardWidget({
    Key? key,
    required this.child,
    required this.keyValue,
    this.onDismissToLeft,
    this.onDismissToRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(keyValue),
      child: child,
      background: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.edit,
              color: Colors.green,
              size: 30,
            )
          ],
        ),
      ),
      secondaryBackground: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.red,
              size: 30,
            )
          ],
        ),
      ),
      onDismissed: (direction) {
        if (DismissDirection.endToStart == direction &&
            onDismissToLeft != null) {
          onDismissToLeft!();
        } else if (DismissDirection.startToEnd == direction &&
            onDismissToRight != null) {
          onDismissToRight!();
        }
      },
    );
  }
}
