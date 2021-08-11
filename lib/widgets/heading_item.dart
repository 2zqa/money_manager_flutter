import 'package:flutter/material.dart';

class HeadingItem extends StatelessWidget {

  const HeadingItem({Key? key, required this.heading}) : super(key: key);

  final String heading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.only(left: 20.0),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          heading,
          // https://material.io/archive/guidelines/components/subheaders.html#subheaders-list-subheaders
          style: Theme.of(context).textTheme.subtitle2?.copyWith(
            color: Theme.of(context).textTheme.caption?.color,
          ),
        ),
      ),
    );
  }
}