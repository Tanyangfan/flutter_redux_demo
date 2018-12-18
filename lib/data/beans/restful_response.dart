class RestfulResponse {
  final String code;
  final String msg;
  final dynamic data;

  RestfulResponse({this.code, this.msg, this.data});

  RestfulResponse.fromJson(Map<String, dynamic> json)
      : code = json['code'].toString(),
        msg = json['msg'],
        data = json['data'];

  @override
  String toString() {
    return 'RestfulResponse{code: $code, msg: $msg, data: $data}';
  }
}
