/// message : "success"
/// status : "200"
/// data : [{"id":1,"nisn":null,"name":"Enricko Hartono","email":"Enricko.putra028@gmail.com","jurusan":"none","kelas":0,"level":"owner","no_telpon":81231231231,"image_profile":"0-none-Enricko-Hartono-ZAYm3ZeeZrqL6477btKtw4jSNiyDt7SHgH9w0oKv9YwLF8wgmX-profile.jpeg","created_at":null,"updated_at":"2022-11-16T12:28:03.000000Z"},{"id":4,"nisn":2,"name":"imam","email":"imam@gmail.com","jurusan":"RPL","kelas":3,"level":"siswa","no_telpon":81234676321,"image_profile":"3-RPL-imam-AnyConv.com__DEMONSAC-175x238.png","created_at":null,"updated_at":"2022-11-15T01:08:10.000000Z"},{"id":8,"nisn":null,"name":"Hartono","email":"SKANSABA@gmail.com","jurusan":"none","kelas":null,"level":"orangtua","no_telpon":88897987816,"image_profile":"-none-Hartono-8lMApDDlwecCYkjrpwcOJuC5n4ukNIkjAJfaUHGLIGKKLyCNFv-profile.jpeg","created_at":null,"updated_at":"2022-11-16T12:36:14.000000Z"},{"id":9,"nisn":5,"name":"danang","email":"danang@gmail.com","jurusan":"RPL","kelas":3,"level":"siswa","no_telpon":89812783687,"image_profile":"3-RPL-danang-nxWUau4hZ559g9nxsGJuEPb1qKr7RtSSeWOQls3q2o7DZB3s1k-pika.gif","created_at":null,"updated_at":"2022-11-16T12:40:53.000000Z"}]
/// total : 4

class UserList {
  UserList({
      String? message, 
      String? status, 
      List<Data>? data, 
      num? total,}){
    _message = message;
    _status = status;
    _data = data;
    _total = total;
}

  UserList.fromJson(dynamic json) {
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
UserList copyWith({  String? message,
  String? status,
  List<Data>? data,
  num? total,
}) => UserList(  message: message ?? _message,
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

/// id : 1
/// nisn : null
/// name : "Enricko Hartono"
/// email : "Enricko.putra028@gmail.com"
/// jurusan : "none"
/// kelas : 0
/// level : "owner"
/// no_telpon : 81231231231
/// image_profile : "0-none-Enricko-Hartono-ZAYm3ZeeZrqL6477btKtw4jSNiyDt7SHgH9w0oKv9YwLF8wgmX-profile.jpeg"
/// created_at : null
/// updated_at : "2022-11-16T12:28:03.000000Z"

class Data {
  Data({
      num? id, 
      dynamic nisn, 
      String? name, 
      String? email, 
      String? jurusan, 
      num? kelas, 
      String? level, 
      num? noTelpon, 
      String? imageProfile, 
      dynamic createdAt, 
      String? updatedAt,}){
    _id = id;
    _nisn = nisn;
    _name = name;
    _email = email;
    _jurusan = jurusan;
    _kelas = kelas;
    _level = level;
    _noTelpon = noTelpon;
    _imageProfile = imageProfile;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _nisn = json['nisn'];
    _name = json['name'];
    _email = json['email'];
    _jurusan = json['jurusan'];
    _kelas = json['kelas'];
    _level = json['level'];
    _noTelpon = json['no_telpon'];
    _imageProfile = json['image_profile'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  dynamic _nisn;
  String? _name;
  String? _email;
  String? _jurusan;
  num? _kelas;
  String? _level;
  num? _noTelpon;
  String? _imageProfile;
  dynamic _createdAt;
  String? _updatedAt;
Data copyWith({  num? id,
  dynamic nisn,
  String? name,
  String? email,
  String? jurusan,
  num? kelas,
  String? level,
  num? noTelpon,
  String? imageProfile,
  dynamic createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  nisn: nisn ?? _nisn,
  name: name ?? _name,
  email: email ?? _email,
  jurusan: jurusan ?? _jurusan,
  kelas: kelas ?? _kelas,
  level: level ?? _level,
  noTelpon: noTelpon ?? _noTelpon,
  imageProfile: imageProfile ?? _imageProfile,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  dynamic get nisn => _nisn;
  String? get name => _name;
  String? get email => _email;
  String? get jurusan => _jurusan;
  num? get kelas => _kelas;
  String? get level => _level;
  num? get noTelpon => _noTelpon;
  String? get imageProfile => _imageProfile;
  dynamic get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['nisn'] = _nisn;
    map['name'] = _name;
    map['email'] = _email;
    map['jurusan'] = _jurusan;
    map['kelas'] = _kelas;
    map['level'] = _level;
    map['no_telpon'] = _noTelpon;
    map['image_profile'] = _imageProfile;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}