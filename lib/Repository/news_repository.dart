import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_news_app/Models/categories_new_model.dart';
import 'package:my_news_app/Models/news_channel_headlines_model.dart';
class NewsRepository {

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesApi() async {
    String url ="https://newsapi.org/v2/everything?q=us&apiKey=36765075ff384ed9aaa2c6c8475cc601" ;
    
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);

    }
    throw Exception("Error");
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    String url =" https://newsapi.org/v2/everything?q=${category}&apiKey=36765075ff384ed9aaa2c6c8475cc601" ;

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return CategoriesNewsModel .fromJson(body);

    }
    throw  Exception("Error");
  }

}