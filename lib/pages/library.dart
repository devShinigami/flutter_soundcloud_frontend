import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sound_cloud_clone/components/app_bar.dart';
import 'package:sound_cloud_clone/utils/library_routes.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const Library(),
        );
      },
    );
  }
}

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: MyAppBar(
        controller: _controller,
        title: "Library",
        isUsedAsSliver: false,
      ),
      body: Scrollbar(
        thickness: 1,
        child: SingleChildScrollView(
          controller: _controller,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 100, right: 16, left: 16, bottom: 130),
            child: Column(
              children: [
                ...getRoutes(context),
                Container(
                  height: 1000,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
