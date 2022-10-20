import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobar/Service/ContentService.dart';
import 'package:kobar/UI/Models/Header.dart';

abstract class HeaderEvent {}

class getContents extends HeaderEvent {}

abstract class HeaderState {}

class HeaderUninitialized extends HeaderState {}

class HeaderLoaded extends HeaderState {
  List<Header> headers;

  HeaderLoaded({required this.headers});
}

class HeaderBloc extends Bloc<HeaderEvent, HeaderState> {
  HeaderBloc(HeaderState initialState) : super(initialState) {
    on<getContents>((event, emit) async {
      var headers = await ContentService.getContent();
      emit(HeaderLoaded(headers: headers));
    });
  }
}
