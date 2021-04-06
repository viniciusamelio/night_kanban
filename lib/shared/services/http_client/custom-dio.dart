import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

class HttpClient extends DioForNative {
  HttpClient({BaseOptions baseOptions}) {
    if (baseOptions != null) {
      this.options = baseOptions;
    } else {
      this.options = BaseOptions(baseUrl: "https://kanban-php.herokuapp.com");
    }
  }
}
