import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobar/Service/ContentService.dart';
import 'package:kobar/UI/Models/Place.dart';

abstract class CategoryEvent {}

class getCategories extends CategoryEvent {}

class getPlaceByCategories extends CategoryEvent {
  int category_id;
  String? keyword;

  getPlaceByCategories({required this.category_id, this.keyword});
}

abstract class CategoryState {}

class CategoryUninitialized extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  List<Place> places;

  CategoryLoaded({required this.places});
}

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc(CategoryState initialState) : super(initialState) {
    on<getPlaceByCategories>((event, emit) async {
      var id = event.category_id;

      emit(CategoryLoading());

      var tours = await ContentService.getTours(id, event.keyword);

      emit(CategoryLoaded(places: tours));
    });
  }
}
