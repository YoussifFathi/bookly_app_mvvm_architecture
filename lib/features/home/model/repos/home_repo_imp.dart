import 'package:bookly_app/core/errors/failures.dart';
import 'package:bookly_app/core/utilities/api_handler.dart';
import 'package:bookly_app/features/home/model/models/book_model.dart';
import 'package:bookly_app/features/home/model/repos/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImp extends HomeRepo {
  @override
  Future<Either<Failures, List<BookModel>>> fetchNewBooks() async {
    try {
      var jsonData = await ApiHandler().get(
          endPoints:
              'volumes?q=subject:programming&filtering=free-ebooks&sorting=newest');
      List<BookModel> bookModelList = [];
      for (var data in jsonData['items']) {
        bookModelList.add(BookModel.fromJson(data));
      }
      return right(bookModelList);
    } catch (e) {
      if(e is DioException){
        return left(ServerSideError.fromDioException(e));
      }else{
        return left(ServerSideError(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failures, List<BookModel>>> fetchFeaturedBook() {
    // TODO: implement fetchFeaturedBook
    throw UnimplementedError();
  }
}