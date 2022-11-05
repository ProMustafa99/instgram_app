// class AddAccountUserModel
// {
//   late String name;
//   late String email;
//   late String phone;
//   late String uId;
//   late String image;
//   late String image_cover;
//   late String bio;
//
//   AddAccountUserModel(
//       this.name,
//       this.email,
//       this.phone ,
//       this.uId ,
//       this.image,
//       this.image_cover,
//       this.bio
//       );
//   AddAccountUserModel.fromJson(Map<String,dynamic> json)
//   {
//
//     email =json['email'];
//     name =json['name'];
//     phone =json['phone'];
//     uId =json['uid'];
//     image = json['image'];
//     image_cover = json['cover'];
//     bio = json['bio'];
//   }
//   Map<String,dynamic> toMap()
//   {return
//     {
//       'name':name ,
//       'email':email ,
//       'phone':phone ,
//       'uid':uId,
//       'image': image,
//       'cover' : image_cover,
//       'bio' :bio
//     };}
//
// }