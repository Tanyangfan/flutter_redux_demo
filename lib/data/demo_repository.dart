import 'package:flutter_redux_demo/data/beans/restful_response.dart';
import 'package:flutter_redux_demo/data/demo_service.dart';

class DemoRepository {
  static final DemoRepository _singleton = new DemoRepository._internal();

  factory DemoRepository() {
    return _singleton;
  }

  DemoService _demoService;

  DemoRepository._internal() {
    _demoService = DemoService();
  }

  Future<RestfulResponse> fetchPoem() {
    return _demoService.fetchPoem();
  }
}
