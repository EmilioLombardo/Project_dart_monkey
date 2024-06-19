import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'sticky_header.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart' show rootBundle;

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final List<String> markdownFiles = [
    'assets/markdown1.md',
    'assets/markdown2.md',
    'assets/markdown3.md',
  ];
  String? selectedMarkdownContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          StickyHeader(),
          SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: markdownFiles.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => _loadMarkdownFile(markdownFiles[index]),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text('Markdown ${index + 1}'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 2,
                  child: selectedMarkdownContent == null
                    ? Center(child: Text('Select a file to view'))
                    : Markdown(data: selectedMarkdownContent!),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _loadMarkdownFile(String filePath) async {
    try {
      final content = await rootBundle.loadString(filePath);
      setState(() {
        selectedMarkdownContent = content;
      });
    } catch (e) {
      setState(() {
        selectedMarkdownContent = 'Error loading markdown file: $filePath';
      });
    }
  }
}
