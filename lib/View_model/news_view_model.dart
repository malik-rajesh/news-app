import 'package:my_news_app/Models/categories_new_model.dart';
import 'package:my_news_app/Models/news_channel_headlines_model.dart';
import 'package:my_news_app/Repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();
//////////////////////////////Rajesh Chack this line code//////////////////////////////// error
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesApi() async {
    final response = await  _rep.fetchNewsChannelsHeadlinesApi();
    return response;
  }


  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
  final response = await  _rep.fetchCategoriesNewsApi(category);
  return response;
  }
  }


