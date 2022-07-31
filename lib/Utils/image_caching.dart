import 'package:amplify_flutter/amplify_flutter.dart';

import '../Models/User.dart';
import '../Models/User.dart';

class ImageUrlCache{
  //Singleton class
  ImageUrlCache._constructor();
  static final ImageUrlCache _instance = ImageUrlCache._constructor();
  static ImageUrlCache get instance => _instance;

  //Creiamo una mappa url-file
Map<String?, String?> _urlCache = Map();
void deleteUrl(String? imagekey){
  _urlCache.removeWhere((key, value) => key == imagekey);
}
Future<String> getUrl(String? imageKey) async{
  if(imageKey == null){
    return " ";
  }
  String? url = _urlCache[imageKey];
  if(url == null){
   try{
    url = (await Amplify.Storage.getUrl(key: imageKey)).url;
    _urlCache[imageKey] = url;
   }catch(e){
     print(e);
     throw e;
   }
  return url;

  }
  return url;


}

  Future<String> getUrlByUser(User user) async{
   if(user.avatarKey ==  null ) return " ";
    var imageKey =  user.avatarKey;

    String? url = _urlCache[imageKey];
    if(url == null){
      try{
        url = (await Amplify.Storage.getUrl(key: imageKey!)).url;
        _urlCache[imageKey] = url;
      }catch(e){
        print(e);
        throw e;
      }


    }
      return url;


  }





}