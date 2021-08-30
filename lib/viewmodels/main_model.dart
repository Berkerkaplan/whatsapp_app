import 'package:whatsapp_app/screens/contacts_page.dart';
import 'package:whatsapp_app/viewmodels/base_model.dart';

class MainModel extends BaseModel {
  Future<void> navigateToContact() {
    return navigatorService.navigateTo(ContactsPage());
  }
}
