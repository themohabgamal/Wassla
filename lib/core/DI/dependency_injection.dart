import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:grad/business_logic/cart/bloc/bloc/cart_bloc.dart';
import 'package:grad/business_logic/home/bloc/home_bloc.dart';
import 'package:grad/repos/category/category_repo.dart';
import '../networking/firebase_helper.dart';

final getIt = GetIt.instance;

setupDependencyInjection() {
  getIt.registerLazySingleton<FirebaseHelper>(() => FirebaseHelper());
  getIt.registerLazySingleton<HomeBloc>(() => HomeBloc());
  print(FirebaseAuth.instance.currentUser!.uid);
  getIt.registerLazySingleton<CartBloc>(
      () => CartBloc(FirebaseAuth.instance.currentUser!.uid));
  getIt.registerSingleton<CategoryRepo>(CategoryRepo());
}
