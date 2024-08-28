import 'package:assign01/utils/colors.dart';
import 'package:flutter/material.dart';

class ExpandableDescription extends StatefulWidget {
  final String description;

  const ExpandableDescription({super.key, required this.description});

  @override
  _ExpandableDescriptionState createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<ExpandableDescription> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Text(
        widget.description,
        maxLines: _isExpanded ? null : 2,
        overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        style: const TextStyle(color: lightColor, fontSize: 16),
      ),
    );
  }
}