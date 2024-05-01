import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad/models/category_response_model.dart';
import 'package:grad/models/hot_deal_model.dart';
part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial()) {
    on<CategoriesNavigateToSingleProductPageEvent>(
        categoriesNavigateToSingleProductPageEvent);
    on<CategoriesNavigateBackEvent>(categoriesNavigateBackEvent);
  }

  FutureOr<void> categoriesNavigateToSingleProductPageEvent(
      CategoriesNavigateToSingleProductPageEvent event,
      Emitter<CategoriesState> emit) {
    emit(CategoriesNavigateToSingleProductState(
        categoryResponseModel: event.categoryResponseModel!));
  }

  FutureOr<void> categoriesNavigateBackEvent(
      CategoriesNavigateBackEvent event, Emitter<CategoriesState> emit) {
    emit(CategoriesNavigateBackState());
  }
}
