import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sound_cloud_clone/components/app_bar.dart';
import 'package:sound_cloud_clone/components/bs_edit_selected_track.dart';
import 'package:sound_cloud_clone/components/update_loader.dart';
import 'package:sound_cloud_clone/pages/activity.dart';
import 'package:sound_cloud_clone/utils/check_connectivity.dart';
import 'package:sound_cloud_clone/utils/toast.dart';

class HomePage extends StatelessWidget {
  final ScrollController controller;
  const HomePage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Home(controller: controller),
        );
      },
    );
  }
}

class Home extends StatefulWidget {
  final ScrollController controller;
  const Home({
    super.key,
    required this.controller,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = false;

  void _pickTrack(BuildContext context) async {
    setState(() {
      loading = true;
    });
    final isConnectedToInternet = await hasInternet();
    if (!isConnectedToInternet) {
      setState(() {
        loading = false;
      });
      getToast('No internet connection');
      return;
    }
    setState(() {
      loading = false;
    });
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );
    if (result != null) {
      if (context.mounted) {
        showBottomSheet(
          context: context,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - 50,
          ),
          showDragHandle: true,
          backgroundColor: Theme.of(context).primaryColor,
          builder: (BuildContext context) {
            return BsEditSelectedTrack(
              result: result,
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        isUsedAsSliver: false,
        controller: widget.controller,
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          IconButton(
            onPressed: () => _pickTrack(context),
            icon: loading
                ? const UpdateLoader()
                : SvgPicture.asset(
                    'assets/icons/uploadtrack.svg',
                    height: 24,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.secondary,
                        BlendMode.srcIn),
                  ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ActivityPage(),
                ),
              );
            },
            icon: SvgPicture.asset(
              'assets/icons/messages.svg',
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.secondary, BlendMode.srcIn),
            ),
          ),
        ],
      ),
      body: Scrollbar(
        thickness: 1,
        radius: const Radius.circular(20),
        child: SingleChildScrollView(
          controller: widget.controller,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 100.0, right: 16, left: 16, bottom: 130.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "More of what you like",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 1000,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.withOpacity(0.4),
                        Colors.redAccent,
                      ],
                    ),
                  ),
                ),
                const Text("End"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
