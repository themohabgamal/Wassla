import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:grad/repos/category/category_repo.dart';

import '../networking/firebase_helper.dart';

final getIt = GetIt.instance;

setupDependencyInjection() {
  log("get in instanciated");
  getIt.registerLazySingleton<FirebaseHelper>(() => FirebaseHelper());
  getIt.registerSingleton<CategoryRepo>(CategoryRepo());
}
