import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      body: Row(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
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
          Flexible(
            flex: 2,
            fit: FlexFit.loose,
            child: selectedMarkdownContent == null
                ? Center(child: Text('Select a file to view'))
                : Markdown(
                    data: selectedMarkdownContent!,
                    styleSheet: MarkdownStyleSheet(
                      p: TextStyle(fontFamily: 'CustomFont', fontSize: 16.0),
                      h1: TextStyle(fontFamily: 'CustomFont', fontSize: 24.0, fontWeight: FontWeight.bold),
                      h2: TextStyle(fontFamily: 'CustomFont', fontSize: 20.0, fontWeight: FontWeight.bold),
                      h3: TextStyle(fontFamily: 'CustomFont', fontSize: 18.0, fontWeight: FontWeight.bold),
                      h4: TextStyle(fontFamily: 'CustomFont', fontSize: 16.0, fontWeight: FontWeight.bold),
                      h5: TextStyle(fontFamily: 'CustomFont', fontSize: 14.0, fontWeight: FontWeight.bold),
                      h6: TextStyle(fontFamily: 'CustomFont', fontSize: 12.0, fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
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
