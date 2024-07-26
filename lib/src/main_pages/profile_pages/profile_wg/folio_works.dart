import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workmai/methods/user_provider.dart';
import 'package:workmai/src/decor/chip.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/edit_profile_wg/files_box.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/edit_profile_wg/works_box.dart';

class FolioWorks extends StatefulWidget {
  final bool? isEdit;
  final List<Widget> videos;
  final List<Widget> files;
  final List<Widget> links;

  const FolioWorks({
    super.key,
    this.isEdit,
    required this.videos,
    required this.files,
    required this.links,
  });

  @override
  State<FolioWorks> createState() => _FolioWorksState();
}

class _FolioWorksState extends State<FolioWorks> {
  final List<Widget> videos = [];
  final List<Widget> files = [Text('file1'), Text('file2')];
  final List<String> links = ['links1', 'links2', 'links3', 'links1', 'links1',];

  @override
  void initState() {
    check();
    super.initState();
  }

  void check() {
    if (widget.isEdit ?? false) {
      _addEditItem();
    }
  }

  void _addEditItem() {
    setState(() {
      widget.videos.insert(
        0,
        videoBox(
          context,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_circle_outline,
              color: Color(0xffFFFFFF),
            ),
          ),
        ),
      );
      widget.files.insert(
        0,
        fileBox(
          context,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_circle_outline,
              color: Color(0xffFFFFFF),
            ),
          ),
        ),
      );
      links.insert(
        0,
        'Add new links',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double dimension1 = 200;
    double dimension2 = 120;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.01,
        horizontal: MediaQuery.sizeOf(context).width * 0.02,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WORKS',
                  style: GoogleFonts.raleway(
                    color: const Color(0xff327B90),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _videos(context, dimension1),
          const SizedBox(
            height: 10,
          ),
          _files(context, dimension2),
          const SizedBox(
            height: 10,
          ),
          _links(context, dimension2),
        ],
      ),
    );
  }

  Widget _videos(BuildContext context, double dimension1) {
    return SizedBox(
      height: dimension1,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.videos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: widget.videos[index],
          );
        },
      ),
    );
  }

  Widget _files(BuildContext context, double dimension2) {
    return SizedBox(
      height: dimension2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.files.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: widget.files[index],
          );
        },
      ),
    );
  }

  Widget videoBox(BuildContext context, {Widget? child}) {
    return WorksBox(
      child: child ?? Container(),
    );
  }

  Widget fileBox(BuildContext context, {Widget? child}) {
    return FilesBox(
      child: child ?? Container(),
    );
  }

  void addLink() {

  }

  Widget _links(BuildContext context, double dimension) {
    return SizedBox(
      height: dimension * 0.8,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: links.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              '${links[index]}', //TODO
              style: GoogleFonts.raleway(
                  color: const Color(0xff6DD484),
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          );
        },
      ),
    );
  }
}
