import 'dart:ui';

import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool isUsedAsSliver;
  final ScrollController controller;
  final List<IconButton> actions;
  const MyAppBar({
    super.key,
    required this.isUsedAsSliver,
    required this.controller,
    required this.title,
    required this.actions,
  });

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  bool _isVisible = false;
  bool _isFilterNotVisible = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateBorderVisibility);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateBorderVisibility);
    super.dispose();
  }

  void _updateBorderVisibility() {
    final showBorder = widget.controller.offset > 10;
    final showFilter = widget.controller.offset < 100;
    if (showBorder != _isVisible) {
      setState(() {
        _isVisible = showBorder;
      });
    }
    if (showFilter != _isFilterNotVisible) {
      setState(() {
        _isFilterNotVisible = showFilter;
      });
    }
  }

  Widget getFlexibleSpace() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              bottom: BorderSide(
                  color: _isVisible
                      ? Theme.of(context).colorScheme.secondary.withOpacity(0.4)
                      : Colors.transparent,
                  width: 0.5),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: widget.isUsedAsSliver && _isFilterNotVisible
          ? null
          : getFlexibleSpace(),
      backgroundColor: widget.isUsedAsSliver && _isFilterNotVisible
          ? Colors.transparent
          : Theme.of(context).primaryColor.withAlpha(200),
      centerTitle: true,
      elevation: 0,
      actions: widget.actions,
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
