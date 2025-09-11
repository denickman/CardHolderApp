import 'package:flutter/material.dart';

class LineItem extends StatelessWidget {
  final String line;

  const LineItem({super.key, required this.line});

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      data:
          line, // Это данные, которые будут «переданы» во время перетаскивания.
      dragAnchorStrategy: childDragAnchorStrategy,
      feedback: Container(
        // Это то, что будет под пальцем во время перетаскивания.
        key: GlobalKey(),
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(color: Colors.black45),
        child: Text(
          line,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: Colors.white),
        ),
      ),
      child: Chip(
        label: Text(line),
      ), // Это то, что отображается на экране постоянно
    );
  }
}
