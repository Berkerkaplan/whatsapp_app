import 'package:whatsapp_app/screens/contacts_page.dart';
import 'package:whatsapp_app/viewmodels/base_model.dart';

class WhatsappMainModel extends BaseModel {
  //Burayı ilerde düzelt
  openContacts() async {
    await navigatorService.navigateTo(ContactsPage());
  }
  //Burası hatalı
  // Future<void> navigateToContacts() {
  //   return navigatorService.navigateTo(ContactsPage());
  // }
}
