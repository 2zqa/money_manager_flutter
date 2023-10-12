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
    final Color transitionColor = Theme.of(context).colorScheme.secondary;
    return OpenContainer(
      transitionType: _transitionType,
      openColor: transitionColor,
      middleColor: transitionColor,
      closedColor: transitionColor,
      closedShape: const CircleBorder(),
      closedElevation: 6,
      openBuilder: (BuildContext context, _) => _route,
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return FloatingActionButton(
          elevation: 0,
          // Rendering a circle in a circle with the same size
          // gives some minor artifacts around the edges.
          // Also, contrary to the name, a roundedrectangleborder
          // without parameters is just a regular rectangle.
          shape: const RoundedRectangleBorder(),
          onPressed: () => openContainer(),
          child: const Icon(Icons.add),
        );
      },
    );
  }
}
