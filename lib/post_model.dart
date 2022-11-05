class post_model
{
  late String name;
  late String user_id;
  late String Date_Time;
  late String Text;
  late String Post_image;
  late String image_user;

  post_model(
      this.name,
      this.user_id ,
      this.Date_Time,
      this.Text,
      this.Post_image,
      this.image_user,
      );
  post_model.fromJson(Map<String,dynamic> json)
  {
    name =json['name'];
    user_id =json['user_id'];
    Date_Time =json['Date_Time'];
    Text = json['Text'];
    Post_image = json['Post_image'];
    image_user = json['image_user'];

  }
  Map<String,dynamic> toMap()
  {return
    {
      'name':name ,
      'user_id':user_id,
      'Date_Time' : Date_Time,
      'Text': Text,
      'Post_image' :Post_image,
      'image_user' :image_user
    };}

}