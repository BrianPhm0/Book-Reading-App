import 'dart:async';
import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/features/book/presentation/bloc/book/bloc/category/book_bloc.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/foundation.dart'; // For `compute`

class ReadingBook extends StatefulWidget {
  final String pdfPath;

  const ReadingBook({super.key, required this.pdfPath});

  @override
  // ignore: library_private_types_in_public_api
  _ReadingBookState createState() => _ReadingBookState();
}

class _ReadingBookState extends State<ReadingBook> {
  int totalPages = 0;
  int currentPage = 0;
  bool isFullScreen = false;
  bool isLoading = true;
  late PdfViewerController _pdfViewerController;
  late String pdfFilePath;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    _loadPdfFile(); // Load PDF in a separate Isolate
  }

  Future<void> _loadPdfFile() async {
    final path =
        await compute(loadPdfPath, widget.pdfPath); // Run in separate Isolate
    setState(() {
      pdfFilePath = path;
      isLoading = false;
    });
  }

  static Future<String> loadPdfPath(String path) async {
    // Simulate a delay if necessary, or perform actual file reading here
    await Future.delayed(
        const Duration(milliseconds: 200)); // Optional: simulate delay
    return path; // Here you could add additional processing if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isFullScreen
          ? CustomAppBar(
              leading: IconButton(
                icon: const Icon(Icons.close_fullscreen_outlined),
                onPressed: () {
                  setState(() {
                    isFullScreen = false;
                  });
                },
              ),
            )
          : CustomAppBar(
              title: 'Reading',
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.read<BookBloc>().add(GetPurchaseBookEvent());
                  Navigator.of(context).pop();
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.fullscreen_outlined),
                  onPressed: () {
                    setState(() {
                      isFullScreen = true;
                    });
                  },
                ),
              ],
            ),
      body: Stack(
        children: [
          if (!isLoading)
            Column(
              children: [
                Expanded(
                  child: SfPdfViewer.network(
                    pdfFilePath,
                    controller: _pdfViewerController,
                    onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                      setState(() {
                        totalPages = details.document.pages.count;
                      });
                    },
                    onPageChanged: (PdfPageChangedDetails details) {
                      setState(() {
                        currentPage = details.newPageNumber;
                      });
                    },
                  ),
                ),
                Visibility(
                  visible: !isFullScreen,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.navigate_before),
                        onPressed: () {
                          _pdfViewerController.previousPage();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextCustom(
                            text: 'Page $currentPage of $totalPages',
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      IconButton(
                        icon: const Icon(Icons.navigate_next),
                        onPressed: () {
                          _pdfViewerController.nextPage();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          if (isLoading)
            const Center(
              child: Loader(size: 50.0, color: Colors.black),
            ),
        ],
      ),
    );
  }
}
