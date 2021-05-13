import 'package:get_it/get_it.dart';
import 'package:pet_mart/utilities/call_services.dart';



GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerSingleton(CallsAndMessagesService());
}