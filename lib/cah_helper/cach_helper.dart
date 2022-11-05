import 'package:shared_preferences/shared_preferences.dart';

class Cash_Data{

  late SharedPreferences Data ;
  Future Save_Data({required String key , required dynamic value }) async
  {
    Data = await SharedPreferences.getInstance();
    if(value is String)
    {return await  Data.setString(key, value);}
    if (value is int)
    {return await  Data.setInt(key, value);}
    if (value is bool)
    {return await  Data.setBool(key, value);}
    return await  Data.setDouble(key, value);
  }

  Future<dynamic> getData({required String key}) async
  {
    Data = await SharedPreferences.getInstance();
    return Data.get(key);
  }

  Future RemoveData() async{
    Data = await SharedPreferences.getInstance();
    return await Data.remove("User_Id");
  }



}