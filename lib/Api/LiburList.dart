/// message : "success"
/// status : "200"
/// data : [{"id_libur":"5","libur_mulai":"2022-11-21","libur_sampai":"2022-11-22","created_at":"2022-11-20T02:52:56.000000Z","updated_at":null}]
/// total : 1

class LiburList {
  LiburList({
      String? message, 
      String? status, 
      List<Data>? data, 
      num? total,}){
    _message = message;
    _status = status;
    _data = data;
    _total = total;
}

  LiburList.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _total = json['total'];
  }
  String? _message;
  String? _status;
  List<Data>? _data;
  num? _total;
LiburList copyWith({  String? message,
  String? status,
  List<Data>? data,
  num? total,
}) => LiburList(  message: message ?? _message,
  status: status ?? _status,
  data: data ?? _data,
  total: total ?? _total,
);
  String? get message => _message;
  String? get status => _status;
  List<Data>? get data => _data;
  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['total'] = _total;
    return map;
  }

}

/// id_libur : "5"
/// libur_mulai : "2022-11-21"
/// libur_sampai : "2022-11-22"
/// created_at : "2022-11-20T02:52:56.000000Z"
/// updated_at : null

class Data {
  Data({
      String? idLibur, 
      String? liburMulai, 
      String? liburSampai, 
      String? createdAt, 
      dynamic updatedAt,}){
    _idLibur = idLibur;
    _liburMulai = liburMulai;
    _liburSampai = liburSampai;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _idLibur = json['id_libur'];
    _liburMulai = json['libur_mulai'];
    _liburSampai = json['libur_sampai'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _idLibur;
  String? _liburMulai;
  String? _liburSampai;
  String? _createdAt;
  dynamic _updatedAt;
Data copyWith({  String? idLibur,
  String? liburMulai,
  String? liburSampai,
  String? createdAt,
  dynamic updatedAt,
}) => Data(  idLibur: idLibur ?? _idLibur,
  liburMulai: liburMulai ?? _liburMulai,
  liburSampai: liburSampai ?? _liburSampai,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get idLibur => _idLibur;
  String? get liburMulai => _liburMulai;
  String? get liburSampai => _liburSampai;
  String? get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_libur'] = _idLibur;
    map['libur_mulai'] = _liburMulai;
    map['libur_sampai'] = _liburSampai;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}