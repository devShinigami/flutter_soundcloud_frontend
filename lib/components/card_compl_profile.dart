import 'package:flutter/material.dart';

class CompletedProfileCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isExpanded;

  const CompletedProfileCard({
    super.key,
    required this.data,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 500),
        switchInCurve: Curves.elasticOut,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SlideTransition(
              position: Tween(
                begin: const Offset(0, 1),
                end: const Offset(0, 0),
              ).animate(animation),
              child: child);
        },
        child: isExpanded
            ? Container(
                padding: const EdgeInsets.all(8.0),
                height: 150,
                width: 170,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      data['icon'],
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Text(
                      data['title'],
                    ),
                    Text(
                      data['text'],
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(data['btnText']),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}
