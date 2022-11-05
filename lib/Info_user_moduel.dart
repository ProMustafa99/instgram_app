class InfoUserModel
{
  late String name;
  late String email;
  late String password;
  late String uId;
  late String bio;
  late String image_profile;
  late String image_cover;



  InfoUserModel(
      this.name,
      this.email,
      this.uId ,
      this.password,
      this.bio,
      this.image_profile,
      this.image_cover,
      );
  InfoUserModel.fromJson(Map<String,dynamic> json)
  {

    email =json['email'];
    name =json['name'];
    password =json['password'];
    uId =json['uid'];
    bio = json['bio'];
    image_profile = json['image_profile'];
    image_cover = json['image_cover'];


  }
  Map<String,dynamic> toMap()
  {return
    {
      'name':name ,
      'email':email ,
      'password':password,
      'uid':uId,
      'bio' :bio,
      'image_profile' : image_profile,
      'image_cover' : image_cover

    };}

}