class AddUserModel
{
  late String name;
  late String email;
  late String password;
  late String uId;


  AddUserModel(
      this.name,
      this.email,
      this.uId ,
      this.password
      );
  AddUserModel.fromJson(Map<String,dynamic> json)
  {

    email =json['email'];
    name =json['name'];
    password =json['password'];
    uId =json['uid'];


  }
  Map<String,dynamic> toMap()
  {return
    {
      'name':name ,
      'email':email ,
      'password':password,
      'uid':uId,

    };}

}