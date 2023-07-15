import 'package:flutter/material.dart';
import 'package:news_project/src/services/news_service.dart';
import 'package:news_project/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

/// *
/// Se utiliza StatefulWidget en esta página para mantener 
/// el estado y no perder el scroll cuando se cambia de pantalla
/// 
 
class Tab1Page extends StatefulWidget {
   
  const Tab1Page({Key? key}) : super(key: key);

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}
/// *
/// AutomaticKeepAliveClientMixin para mantener la información del scroll
/// 

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: (newsService.headlines.length == 0)
        ? Center(child: CircularProgressIndicator(),)
        : NewsList(newsService.headlines)
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}