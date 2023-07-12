class UserModel
{
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? coverImage;
  String? profileImage;
  String? bio;

  UserModel(
      this.name,
      this.email,
      this.phone,
      this.uId,
  );

  UserModel.fromJason(Map<String,dynamic>? jason)
  {
    name = jason!['name'];
    email = jason['email'];
    phone = jason['phone'];
    uId = jason['uId'];
    profileImage = jason['profileImage'];
    bio = jason['bio'];
    coverImage = jason['coverImage'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'profileImage':profileImage,
      'bio':bio,
      'coverImage':coverImage,
    };
  }
}