/// message : "Login dahulu"
/// status : "200"

class PresensiPost {
  PresensiPost({
      String? message, 
      String? status,}){
    _message = message;
    _status = status;
}

  PresensiPost.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
  }
  String? _message;
  String? _status;
PresensiPost copyWith({  String? message,
  String? status,
}) => PresensiPost(  message: message ?? _message,
  status: status ?? _status,
);
  String? get message => _message;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    return map;
  }

}