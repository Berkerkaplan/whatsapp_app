import 'package:get_it/get_it.dart';
import 'package:whatsapp_app/core/services/auth_service.dart';
import 'package:whatsapp_app/core/services/chat_service.dart';
import 'package:whatsapp_app/core/services/navigator_service.dart';
import 'package:whatsapp_app/viewmodels/chat_model.dart';
import 'package:whatsapp_app/viewmodels/contacts_model.dart';
import 'package:whatsapp_app/viewmodels/main_model.dart';
import 'package:whatsapp_app/viewmodels/whatsapp_main_model.dart';
import 'package:whatsapp_app/viewmodels/sign_in_model.dart';

GetIt getIt = GetIt.instance;
setUpLocator() {
  getIt.registerLazySingleton(() => NavigatorService());
  getIt.registerLazySingleton(() => ChatService());
  getIt.registerLazySingleton(() => AuthService());

  getIt.registerFactory(() => ChatsModel());
  getIt.registerFactory(() => MainModel());
  getIt.registerFactory(() => WhatsappMainModel());
  getIt.registerFactory(() => ContactsModel());
  getIt.registerFactory(() => SignInModel());
}
