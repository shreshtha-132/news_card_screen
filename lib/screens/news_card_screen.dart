import 'package:flutter/material.dart';
import 'package:news_card_screen/widgets/news_card_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NewsCardScreen extends StatefulWidget {
  @override
  _NewsCardScreenState createState() => _NewsCardScreenState();
}

class _NewsCardScreenState extends State<NewsCardScreen> {
  PageController _pageController = PageController(initialPage: 0);
  List<String> videoPaths = [
    "collections/pexels-carolin-wenske-19311447 (2160p).mp4",
    "collections/pexels-feyza-daştan-19140929 (1440p).mp4",
    "collections/pexels-olya-kobruseva-5791995 (1080p).mp4",
  ];

  List<String> videoUrls = [];

  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchVideoUrls();
  }

  Future<void> _fetchVideoUrls() async {
    try {
      List<Future<String>> futures = videoPaths.map((path) async {
        Reference storageReference = FirebaseStorage.instance.ref().child(path);
        return await storageReference.getDownloadURL();
      }).toList();

      videoUrls = await Future.wait(futures);
    } catch (e) {
      print("Error fetching video URLs from Firebase Storage: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          return NewsCardWidget(videoUrl: videoUrls[index]);
        },
        onPageChanged: (index) {
          setState(() {
            currentPageIndex = index;
          });

          print("Changed to video at index: $index");
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
