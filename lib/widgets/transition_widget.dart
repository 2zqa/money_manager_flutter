import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../pages/new_balance_item.dart';

const double fabSize = 56;

class CreateNewBalanceItemCardFAB extends StatelessWidget {
  final ContainerTransitionType transitionType;

  const CreateNewBalanceItemCardFAB({Key? key, required this.transitionType})
      : super(key: key);

  @override
  Widget build(BuildContext context) => OpenContainer(
        openBuilder: (context, _) => NewBalanceItemRoute(),
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
