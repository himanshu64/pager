import 'dart:convert';

import 'package:http/http.dart' as http;

class APIService {
  Future getData(pageNumber) async {
    var url =
        "https://api.shoopy.in/api/v1/org/28052/super-products?online-only=true&child-cat-products=true&page=" +
            pageNumber.toString();
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var listData = json.decode(response.body);
      return listData['payload']['content'];

    } else {
      throw Exception('Failed to load data!');
    }
  }
}
