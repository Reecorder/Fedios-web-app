import 'package:fideos_web/services/api_services.dart';
import 'package:fideos_web/services/endpoints.dart';

import '../common/common_flash_msg.dart';

class MenuService {
  // add menu
  static Future<Map<String, dynamic>> addMenu({body}) async {
    try {
      // Preparing endpoint
      final endpoint = Endpoints.authentication + Endpoints.addMenu;

      final response = await ApiService.post(endpoint: endpoint, data: body);
      return response;
    } catch (error) {
      FlashMessage.show(title: 'Error');
      return {};
    }
  }

  // fetch menu
  static Future<Map<String, dynamic>> fetchMenu() async {
    try {
      // Preparing endpoint
      final endpoint = Endpoints.authentication + Endpoints.fetchMenu;

      final response = await ApiService.get(endpoint: endpoint);
      return response;
    } catch (error) {
      FlashMessage.show(title: 'Error');
      return {};
    }
  }

  // update menu
  static Future<Map<String, dynamic>> updateMenu({body}) async {
    try {
      // Preparing endpoint
      final endpoint = Endpoints.authentication + Endpoints.updateMenu;

      final response = await ApiService.post(endpoint: endpoint, data: body);
      return response;
    } catch (error) {
      FlashMessage.show(title: 'Error');
      return {};
    }
  }
}
