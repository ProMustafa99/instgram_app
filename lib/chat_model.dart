class MessageModel
{

  late String senderId;
  late String receiverId;
  late String Date_Time;
  late String Text;

  MessageModel(
      this.senderId,
      this.receiverId ,
      this.Date_Time,
      this.Text,
      );
  MessageModel.fromJson(Map<String,dynamic> json)
  {
    senderId =json['senderId'];
    receiverId =json['receiverId'];
    Date_Time =json['Date_Time'];
    Text = json['Text'];
  }
  Map<String,dynamic> toMap()
  {return
    {
      'senderId':senderId ,
      'receiverId':receiverId,
      'Date_Time' : Date_Time,
      'Text': Text,
    };}

}