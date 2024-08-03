import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool isUsedAsSliver;
  final ScrollController controller;
  const MyAppBar(
      {super.key,
      required this.isUsedAsSliver,
      required this.controller,
      required this.title});

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
    super.dispose();
    widget.controller.removeListener(_updateBorderVisibility);
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

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      flexibleSpace: widget.isUsedAsSliver && _isFilterNotVisible
          ? null
          : ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 6),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border(
                      bottom: BorderSide(
                          color: _isVisible
                              ? Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.4)
                              : Colors.transparent,
                          width: 0.5),
                    ),
                  ),
                ),
              ),
            ),
      backgroundColor: widget.isUsedAsSliver && _isFilterNotVisible
          ? Colors.transparent
          : Theme.of(context).primaryColor.withAlpha(200),
      centerTitle: true,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/icons/uploadtrack.svg',
            height: 24,
            colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.secondary, BlendMode.srcIn),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/icons/messages.svg',
            height: 24,
            colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.secondary, BlendMode.srcIn),
          ),
        ),
      ],
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
