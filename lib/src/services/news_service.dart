import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_project/src/models/category_model.dart';
import 'package:news_project/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _HOST_NEWS = 'newsapi.org';
final _API_KEY = '6248dc6b82384d3eb28fde4e675927b2';
final _COUNTRY = 'us';

class NewsService with ChangeNotifier {

  List<Article> headlines = [];

  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String,List<Article>> articlesByCategory = {};

  NewsService() {
    getTopHeadlines();
    categories.forEach((element) {
      articlesByCategory[element.name] = [];
    });
  }

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String category) {
    _selectedCategory = category;
    getArticlesByCategory(category);
    notifyListeners();
  }

  List<Article> get getArticlesBySelectedCategory => articlesByCategory[selectedCategory]!;

  getTopHeadlines() async {

    const endpoint = '/v2/top-headlines';
    final url = Uri.https(_HOST_NEWS, endpoint, {
      'apiKey': _API_KEY,
      'country': _COUNTRY,
    });
    final resp = await http.get(url);
    if(resp.statusCode == 200) {
      final newsResponse = newsResponseFromJson(resp.body);

      headlines.addAll(newsResponse.articles);
      notifyListeners();
    } else {
      //
    }

  }

  getArticlesByCategory(String category) async {
    
    if(articlesByCategory[category]!.length > 0) return articlesByCategory[category];

    const endpoint = '/v2/top-headlines';
    final url = Uri.https(_HOST_NEWS, endpoint, {
      'apiKey': _API_KEY,
      'country': _COUNTRY,
      'category': category,
    });
    final resp = await http.get(url);
    if(resp.statusCode == 200) {
      final newsResponse = newsResponseFromJson(resp.body);

      articlesByCategory[category]!.addAll(newsResponse.articles);
      // headlines.addAll(newsResponse.articles);
      notifyListeners();
    } else {
      //
    }

  }

}