/// message : "success"
/// status : "200"
/// data : [{"id_presensi":"44","status":"izin","location":"-7.8883282,110.3558621","time":"1668580324","created_at":"2022-11-16 01:32:04","updated_at":"2022-11-16 13:10:39","user":{"id":1,"nama":"Enricko Hartono","level":"owner","kelas":"0","jurusan":"none"}},{"id_presensi":"46","status":"izin","location":null,"time":"1668645903","created_at":"2022-11-17 07:45:03","updated_at":null,"user":{"id":1,"nama":"Enricko Hartono","level":"owner","kelas":"0","jurusan":"none"}},{"id_presensi":"49","status":"izin","location":null,"time":"1668732306","created_at":"2022-11-18 07:45:06","updated_at":null,"user":{"id":1,"nama":"Enricko Hartono","level":"owner","kelas":"0","jurusan":"none"}},{"id_presensi":"47","status":"alpha","location":null,"time":"1668645903","created_at":"2022-11-17 07:45:03","updated_at":null,"user":{"id":4,"nama":"imam","level":"siswa","kelas":"3","jurusan":"RPL"}},{"id_presensi":"50","status":"alpha","location":null,"time":"1668732306","created_at":"2022-11-18 07:45:06","updated_at":null,"user":{"id":4,"nama":"imam","level":"siswa","kelas":"3","jurusan":"RPL"}},{"id_presensi":"45","status":"hadir","location":"-7.8883421,110.3558462","time":"1668581388","created_at":"2022-11-16 01:49:48","updated_at":"2022-11-16 13:49:33","user":{"id":8,"nama":"Wildan Wigenta","level":"admin","kelas":"0","jurusan":"none"}},{"id_presensi":"48","status":"alpha","location":null,"time":"1668645903","created_at":"2022-11-17 07:45:03","updated_at":null,"user":{"id":8,"nama":"Wildan Wigenta","level":"admin","kelas":"0","jurusan":"none"}},{"id_presensi":"51","status":"alpha","location":null,"time":"1668732306","created_at":"2022-11-18 07:45:06","updated_at":null,"user":{"id":8,"nama":"Wildan Wigenta","level":"admin","kelas":"0","jurusan":"none"}}]
/// total : 8

class PresensiList {
  PresensiList({
      String? message, 
      String? status, 
      List<Data>? data, 
      num? total,}){
    _message = message;
    _status = status;
    _data = data;
    _total = total;
}

  PresensiList.fromJson(dynamic json) {
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
PresensiList copyWith({  String? message,
  String? status,
  List<Data>? data,
  num? total,
}) => PresensiList(  message: message ?? _message,
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

/// id_presensi : "44"
/// status : "izin"
/// location : "-7.8883282,110.3558621"
/// time : "1668580324"
/// created_at : "2022-11-16 01:32:04"
/// updated_at : "2022-11-16 13:10:39"
/// user : {"id":1,"nama":"Enricko Hartono","level":"owner","kelas":"0","jurusan":"none"}

class Data {
  Data({
      String? idPresensi, 
      String? status, 
      String? location, 
      String? time, 
      String? createdAt, 
      String? updatedAt, 
      User? user,}){
    _idPresensi = idPresensi;
    _status = status;
    _location = location;
    _time = time;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
}

  Data.fromJson(dynamic json) {
    _idPresensi = json['id_presensi'];
    _status = json['status'];
    _location = json['location'];
    _time = json['time'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? _idPresensi;
  String? _status;
  String? _location;
  String? _time;
  String? _createdAt;
  String? _updatedAt;
  User? _user;
Data copyWith({  String? idPresensi,
  String? status,
  String? location,
  String? time,
  String? createdAt,
  String? updatedAt,
  User? user,
}) => Data(  idPresensi: idPresensi ?? _idPresensi,
  status: status ?? _status,
  location: location ?? _location,
  time: time ?? _time,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  user: user ?? _user,
);
  String? get idPresensi => _idPresensi;
  String? get status => _status;
  String? get location => _location;
  String? get time => _time;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_presensi'] = _idPresensi;
    map['status'] = _status;
    map['location'] = _location;
    map['time'] = _time;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// id : 1
/// nama : "Enricko Hartono"
/// level : "owner"
/// kelas : "0"
/// jurusan : "none"

class User {
  User({
      num? id, 
      String? nama, 
      String? level, 
      String? kelas, 
      String? jurusan,}){
    _id = id;
    _nama = nama;
    _level = level;
    _kelas = kelas;
    _jurusan = jurusan;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _nama = json['nama'];
    _level = json['level'];
    _kelas = json['kelas'];
    _jurusan = json['jurusan'];
  }
  num? _id;
  String? _nama;
  String? _level;
  String? _kelas;
  String? _jurusan;
User copyWith({  num? id,
  String? nama,
  String? level,
  String? kelas,
  String? jurusan,
}) => User(  id: id ?? _id,
  nama: nama ?? _nama,
  level: level ?? _level,
  kelas: kelas ?? _kelas,
  jurusan: jurusan ?? _jurusan,
);
  num? get id => _id;
  String? get nama => _nama;
  String? get level => _level;
  String? get kelas => _kelas;
  String? get jurusan => _jurusan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['nama'] = _nama;
    map['level'] = _level;
    map['kelas'] = _kelas;
    map['jurusan'] = _jurusan;
    return map;
  }

}