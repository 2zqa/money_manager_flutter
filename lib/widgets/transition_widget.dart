import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

const double fabSize = 56;

class CreateNewBalanceItemCardFAB extends StatelessWidget {
  final ContainerTransitionType transitionType;
  final Widget route;

  const CreateNewBalanceItemCardFAB(
      {Key? key, required this.transitionType, required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) => OpenContainer(
        openBuilder: (context, _) => route,
        closedShape: CircleBorder(),
        closedColor: Theme.of(context).primaryColor,
        closedBuilder: (context, openContainer) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor,
          ),
          height: fabSize,
          width: fabSize,
          child: Icon(Icons.add, color: Colors.white),
        ),
      );
}
