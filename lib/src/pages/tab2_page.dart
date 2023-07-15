import 'package:flutter/material.dart';
import 'package:news_project/src/models/category_model.dart';
import 'package:news_project/src/services/news_service.dart';
import 'package:news_project/src/theme/theme.dart';
import 'package:news_project/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
   
  const Tab2Page({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CategoriesList(),
            Expanded(child: NewsList(newsService.getArticlesBySelectedCategory))
          ],
        ),
      ),
    );
  }
}

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;
    /// Importante colocar el Expanded para que no de error: 
    /// "Failed assertion: line 1966 pos 12: 'hasSize'"
    return Container(
      color: Colors.red,
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final name = categories[index].name;
          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryButton(categories[index]),
                SizedBox(height: 5,),
                Text('${name[0].toUpperCase()}${name.substring(1)}')
              ]
            ),
          );
        }
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {

  final Category category;

  const _CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    Color iconBgColor = Colors.white;
    Color iconColor = Colors.black;
    if(newsService.selectedCategory == category.name){
      iconColor = themeData.colorScheme.secondary;
    }
    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: iconBgColor
        ),
        child: Icon(category.icon, color: iconColor,)
      ),
    );
  }
}