import 'package:get_it/get_it.dart';
import 'package:grad/business_logic/home/bloc/home_bloc.dart';
import 'package:grad/repos/category/category_repo.dart';
import '../networking/firebase_helper.dart';

final getIt = GetIt.instance;

setupDependencyInjection() {
  getIt.registerLazySingleton<FirebaseHelper>(() => FirebaseHelper());
  getIt.registerLazySingleton<HomeBloc>(() => HomeBloc());
  getIt.registerSingleton<CategoryRepo>(CategoryRepo());
}
