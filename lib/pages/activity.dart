import 'package:flutter/material.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Text(
            'Activity',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          centerTitle: true,
          bottom: TabBar(
            enableFeedback: false,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            unselectedLabelColor: Theme.of(context).colorScheme.secondary,
            dividerColor: Theme.of(context).colorScheme.secondary,
            tabs: const [
              Tab(text: 'Notifications'),
              Tab(text: 'Messages'),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Center(
              child: Text('Notifications'),
            ),
            Center(
              child: Text('Messages'),
            ),
          ],
        ),
      ),
    );
  }
}
