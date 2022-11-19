class Data {
  Data({
      this.id, 
      this.nisn, 
      this.name, 
      this.email, 
      this.jurusan, 
      this.kelas, 
      this.level, 
      this.noTelpon, 
      this.imageProfile, 
      this.createdAt, 
      this.updatedAt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    nisn = json['nisn'];
    name = json['name'];
    email = json['email'];
    jurusan = json['jurusan'];
    kelas = json['kelas'];
    level = json['level'];
    noTelpon = json['no_telpon'];
    imageProfile = json['image_profile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int id;
  dynamic nisn;
  String name;
  String email;
  String jurusan;
  int kelas;
  String level;
  int noTelpon;
  String imageProfile;
  dynamic createdAt;
  String updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['nisn'] = nisn;
    map['name'] = name;
    map['email'] = email;
    map['jurusan'] = jurusan;
    map['kelas'] = kelas;
    map['level'] = level;
    map['no_telpon'] = noTelpon;
    map['image_profile'] = imageProfile;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}