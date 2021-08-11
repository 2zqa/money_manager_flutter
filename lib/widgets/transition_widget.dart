import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

/// sdfg
class CreateNewBalanceItemCardFAB extends StatelessWidget {

  /// asdf
  const CreateNewBalanceItemCardFAB(
      {Key? key, required ContainerTransitionType transitionType, required Widget route})
      : _transitionType = transitionType,
        _route = route,
        super(key: key);

  static const double _fabSize = 56;
  final ContainerTransitionType _transitionType;
  final Widget _route;

  @override
  Widget build(BuildContext context) => OpenContainer(
        transitionType: _transitionType,
        closedShape: const CircleBorder(),
        closedColor: Theme.of(context).primaryColor,
        openBuilder: (BuildContext context, _) => _route,
        closedBuilder: (BuildContext context, _) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor,
          ),
          height: _fabSize,
          width: _fabSize,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      );
}
