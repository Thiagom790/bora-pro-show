import 'package:flutter/material.dart';
import 'package:tcc_bora_show/view-models/management.event.viewmodel.dart';
import 'package:tcc_bora_show/widgets/event.card.date.widget.dart';
import 'package:tcc_bora_show/widgets/event.card.widget.dart';

class EventCardContainerWidget extends StatelessWidget {
  final ManagementEventViewModel event;
  final void Function()? onPress;
  const EventCardContainerWidget({
    Key? key,
    required this.event,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPress,
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: EventCardDateWidget(
                date: event.date,
              ),
            ),
            Flexible(
              flex: 8,
              child: EventCardWidget(
                location: event.address,
                status: event.status,
                title: event.title,
              ),
            )
          ],
        ),
      ),
    );
  }
}
