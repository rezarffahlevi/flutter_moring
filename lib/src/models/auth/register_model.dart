class RegisterModel {
  String nama;
  String email;
  String telp;
  String password;
  String confirmPassword;

  RegisterModel(
      {this.nama, this.email, this.telp, this.password, this.confirmPassword});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    email = json['email'];
    telp = json['telp'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    data['email'] = this.email;
    data['telp'] = this.telp;
    data['password'] = this.password;
    data['confirm_password'] = this.confirmPassword;
    return data;
  }
}
