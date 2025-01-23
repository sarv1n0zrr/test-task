import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:test_task/model/newsmodel.dart';

// class NewsList {
//   final dio = Dio();
//   List<ArticleModel> datatobesavedin = [];
//   getArticles() async {
//     var response = await dio.get(
//         'https://newsapi.org/v2/top-headlines?country=us&apiKey=49126d1e109b482398a1ce2299804819');
//     if (response.statusCode == 200) {
//       print(response.data['articles']);
//       // for (var news in response.data["articles"]) {
//       //   datatobesavedin.add(ArticleModel.fromJson(news));
//       // }
//     } else {}
//     return datatobesavedin;
//   }
// }

class NewsList {
  final dio = Dio();
  List<ArticleModel> datatobesavedin = [];

  getArticles() async {
    var response = await dio.get(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=49126d1e109b482398a1ce2299804819');
    if (response.statusCode == 200) {
      var jsonData = response.data; // Use response.data directly
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            url: element['url'],
          );
          datatobesavedin.add(articleModel);
        }
      });
    }
    return datatobesavedin;
  }
}

// fetching news by  category
// class CategoryNews {
//   List<ArticleModel> datatobesavedin = [];

//   final dio = Dio();

//   Future<void> getNews(String category) async {
//     var response = await dio.get(
//         'https://newsapi.org/v2/top-headlines?country=us&apiKey=49126d1e109b482398a1ce2299804819');
//     var jsonData = response.data;

//     if (response.statusCode == 200) {
//       jsonData['articles'].forEach((element) {
//         if (element['urlToImage'] != null && element['description'] != null) {
//           // initliaze our model class

//           ArticleModel articleModel = ArticleModel(
//             title: element['title'],
//             urlToImage: element['urlToImage'],
//             description: element['description'],
//             url: element['url'],
//           );
//           datatobesavedin.add(articleModel);
//         }
//       });
//     }
//   }
// }
class CategoryNews {
  List<ArticleModel> datatobesavedin = [];

  final dio = Dio();

  Future<void> getNews(String category) async {
    var response = await dio.get(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=49126d1e109b482398a1ce2299804819&category=$category');

    if (response.statusCode == 200) {
      var jsonData = response.data; // Use response.data directly
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          // Initialize our model class
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            url: element['url'],
          );
          datatobesavedin.add(articleModel);
        }
      });
    }
  }
}
