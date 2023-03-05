class LoginDetails {
  LoginDetails({
    required this.id,
    required this.location,
    required this.ipAddress,
    required this.qrImage,
    required this.loginTime,
  });
  late String id;
  late final String location;
  late final String ipAddress;
  late String qrImage;
  late final String loginTime;

  LoginDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
    ipAddress = json['ip_address'];
    qrImage = json['qr_image'];
    loginTime = json['login_time'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['location'] = location;
    data['ip_address'] = ipAddress;
    data['qr_image'] = qrImage;
    data['login_time'] = loginTime;
    return data;
  }
}
