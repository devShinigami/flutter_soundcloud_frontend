import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/components/app_bar.dart';
import 'package:sound_cloud_clone/utils/countries.dart';

class BottomSheetCountries extends StatefulWidget {
  final void Function() toggleForm;
  final void Function(String) onCountryChanged;
  const BottomSheetCountries({
    super.key,
    required this.onCountryChanged,
    required this.toggleForm,
  });

  @override
  State<BottomSheetCountries> createState() => _BottomSheetCountriesState();
}

class _BottomSheetCountriesState extends State<BottomSheetCountries> {
  final ScrollController _controller = ScrollController();
  List<String> items = List.from(countriesForPicker);
  List<String> alphabets = List.generate(
    26,
    (i) => String.fromCharCode(i + 65),
  );
  List<String> countriesWithAppendedLetter = [];
  String selectedLetter = 'A';

  @override
  void initState() {
    super.initState();
    appendAlphabetsInTheItems();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final visibleItems = _getVisibleItems();
    if (visibleItems.isNotEmpty) {
      final firstVisibleLetter = visibleItems.first[0];
      if (firstVisibleLetter != selectedLetter) {
        setState(() {
          selectedLetter = firstVisibleLetter;
        });
      }
    }
  }

  List<String> _getVisibleItems() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return [];

    final viewportHeight = renderBox.size.height;
    final scrollOffset = _controller.offset;
    const itemHeight = 56.0;

    final startIndex = (scrollOffset / itemHeight).floor();
    final endIndex = ((scrollOffset + viewportHeight) / itemHeight).ceil();

    return items.sublist(
      startIndex,
      endIndex.clamp(
        0,
        items.length,
      ),
    );
  }

  void appendAlphabetsInTheItems() {
    String currentLetter = '';
    for (String country in items) {
      String firstLetter = country[0].toUpperCase();
      if (firstLetter != currentLetter) {
        currentLetter = firstLetter;
        countriesWithAppendedLetter.add(currentLetter);
      }
      countriesWithAppendedLetter.add(country);
    }
    items = countriesWithAppendedLetter;
  }

  void _scrollToLetter(String letter) {
    final index = items.indexWhere((country) => country.startsWith(letter));
    if (index != -1) {
      _controller.animateTo(
        index * 56.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: MyAppBar(
          leading: IconButton(
            onPressed: widget.toggleForm,
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          isUsedAsSliver: false,
          title: Text(
            'Country',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: const [],
          controller: _controller,
        ),
        body: Stack(
          children: [
            Positioned.fill(
              left: 0,
              right: 0,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _controller,
                      itemCount: items.length,
                      itemBuilder: (context, index) => ListTile(
                        splashColor: Theme.of(context).colorScheme.secondary,
                        onTap: () {
                          widget.onCountryChanged(items[index]);
                          widget.toggleForm();
                        },
                        title: Text(
                          items[index],
                          style: items[index].length == 1
                              ? Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary)
                              : Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ),
                  AlphabetScroller(
                    alphabets: alphabets,
                    selectedLetter: selectedLetter,
                    onLetterSelected: _scrollToLetter,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 55,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                height: 35,
                color: Theme.of(context).primaryColor,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedSwitcher(
                    switchInCurve: Curves.bounceIn,
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) => ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                    child: Text(
                      textAlign: TextAlign.start,
                      key: ValueKey(selectedLetter),
                      selectedLetter,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AlphabetScroller extends StatefulWidget {
  final List<String> alphabets;
  final String selectedLetter;
  final Function(String) onLetterSelected;

  const AlphabetScroller({
    super.key,
    required this.alphabets,
    required this.selectedLetter,
    required this.onLetterSelected,
  });

  @override
  State<AlphabetScroller> createState() => _AlphabetScrollerState();
}

class _AlphabetScrollerState extends State<AlphabetScroller> {
  late String _selectedLetter;
  static const _letterHeight = 18.0;
  @override
  void initState() {
    super.initState();
    _selectedLetter = widget.selectedLetter;
  }

  @override
  void didUpdateWidget(AlphabetScroller oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedLetter != oldWidget.selectedLetter) {
      setState(() {
        _selectedLetter = widget.selectedLetter;
      });
    }
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.globalToLocal(details.globalPosition);
    final totalHeight = renderBox.size.height;
    final alphabetHeight = widget.alphabets.length * _letterHeight;
    final startY = (totalHeight - alphabetHeight) / 2;

    if (position.dy < startY || position.dy > startY + alphabetHeight) {
      return;
    }

    final index = ((position.dy - startY) / _letterHeight)
        .floor()
        .clamp(0, widget.alphabets.length - 1);
    final letter = widget.alphabets[index];

    if (letter != _selectedLetter) {
      setState(() {
        _selectedLetter = letter;
      });
      widget.onLetterSelected(letter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _onVerticalDragUpdate,
      child: Container(
        width: 40,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.alphabets.map((letter) {
            return Container(
              height: _letterHeight,
              width: 40,
              alignment: Alignment.center,
              child: Text(
                letter,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: _selectedLetter == letter
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).textTheme.bodyMedium!.color,
                    ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
