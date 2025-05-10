class UserModel {
  UserModel({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.uuId = '',
    this.tenantId = '',
  });

  String id;
  String firstName;
  String lastName;
  String email;
  String tenantId;
  String uuId;

  factory UserModel.fromMap(Map<dynamic, dynamic> value, String documentID) {
    return UserModel(
      id: documentID,
      firstName: value['first_name'],
      lastName: value['last_name'],
      email: value['email'],
      tenantId: value['tenantId'],
      uuId: value['uuid'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'tenantId': tenantId,
      'uuid': uuId,
    };
  }
}
