import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobar/Service/ContentService.dart';
import 'package:kobar/UI/Models/Transaction.dart';

abstract class OrderEvent {}

class Order extends OrderEvent {
  Transaction data;
  int id;
  Order({
    required this.data,
    required this.id,
  });
}

abstract class OrderState {}

class OrderUninitialized extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  Map<String, dynamic> result;

  OrderLoaded({required this.result});
}

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc(OrderState initialState) : super(initialState) {
    on<Order>((event, emit) async {
      emit(OrderLoading());
      log('order masuk di bloc');
      log('data ${event.data}');

      var tours = await ContentService.createOrder(event.data, event.id);
      log('response $tours');
      emit(OrderLoaded(result: tours));
    });
  }
}
