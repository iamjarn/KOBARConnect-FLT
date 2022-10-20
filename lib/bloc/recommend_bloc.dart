import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobar/Service/ContentService.dart';
import 'package:kobar/UI/Models/Category.dart';

abstract class RecommendEvent {}

class getRecommend extends RecommendEvent {}

abstract class RecommendState {}

class RecommendUninitialized extends RecommendState {}

class RecommendLoaded extends RecommendState {
  List<Category> recommends;

  RecommendLoaded({required this.recommends});
}

class RecommendBloc extends Bloc<RecommendEvent, RecommendState> {
  RecommendBloc(RecommendState initialState) : super(initialState) {
    on<getRecommend>((event, emit) async {
      var recommends = await ContentService.getRecommend();
      emit(RecommendLoaded(recommends: recommends));
    });
  }
}
