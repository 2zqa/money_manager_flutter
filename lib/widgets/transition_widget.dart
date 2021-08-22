import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

/// A FAB that goes to specified route upon clicking.
class CreateNewBalanceItemCardFAB extends StatelessWidget {

  /// Creates a FAB that goes to [route] with the [transitionType] animation.
  const CreateNewBalanceItemCardFAB(
      {Key? key,
      required ContainerTransitionType transitionType,
      required Widget route})
      : _transitionType = transitionType,
        _route = route,
        super(key: key);

  final ContainerTransitionType _transitionType;
  final Widget _route;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: _transitionType,
      closedShape: const CircleBorder(),
      closedColor: Theme.of(context).scaffoldBackgroundColor,
      openColor: Theme.of(context).scaffoldBackgroundColor,
      openBuilder: (BuildContext context, _) => _route,
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return FloatingActionButton(
          onPressed: () => openContainer(),
          child: const Icon(Icons.add),
        );
      },
    );
  }
}
