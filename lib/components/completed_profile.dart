import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sound_cloud_clone/components/card_compl_profile.dart';

class CompletedProflieChecks extends StatefulWidget {
  const CompletedProflieChecks({super.key});

  @override
  State<CompletedProflieChecks> createState() => _CompletedProflieChecksState();
}

class _CompletedProflieChecksState extends State<CompletedProflieChecks> {
  double height = 0;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
          height = _isExpanded ? 170 : 0;
        });
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Complete your Profile',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const Gap(8),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '3 OF 4 ',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                        ),
                        TextSpan(
                          text: 'COMPLETE',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Icon(
                Icons.arrow_downward,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ],
          ),
          const Gap(15),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: height,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: _isExpanded ? 1 : 0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: CompletedProfileCard(
                      data: data[index],
                      isExpanded: _isExpanded,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> data = [
    {
      'icon': Icons.message,
      'title': 'Add a Bio',
      'text': 'What should people know about you?',
      'btnText': 'Add a Bio',
    },
    {
      'icon': Icons.message,
      'title': 'Add Story',
      'text': 'What should people know about you?',
      'btnText': 'Add story',
    },
    {
      'icon': Icons.work,
      'title': 'Add Work Experience',
      'text': 'Where have you worked before?',
      'btnText': 'Add Experience',
    },
    {
      'icon': Icons.school,
      'title': 'Add Education',
      'text': "What's your educational background?",
      'btnText': 'Add Education',
    },
    {
      'icon': Icons.location_on,
      'title': 'Add Location',
      'text': 'Where are you based?',
      'btnText': 'Add Location',
    },
  ];
}
