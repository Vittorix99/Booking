


import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bookingmobile2/Models/User.dart';
import 'package:bookingmobile2/Utils/image_caching.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../Models/Office.dart';

class StorageRepository{

Future<String> uploadFile(File file, User user) async {
  try{

    List<String> partsOfMails= user.mail!.split("@");
    var fileName =partsOfMails[0]+"_profile_image"+".jpg";
    _deleteImageFromCache(fileName);
    ImageUrlCache.instance.deleteUrl(fileName);

    final result = await Amplify.Storage.uploadFile(
    local: file,
    key: fileName
);

return result.key;

  }catch(e){
    throw e;
  }
}

Future<String> uploadOfficeFile(File file, Office office) async{
var fileName = "uffici/"+ "${office.name.replaceAll(" ", "_") }" +".jpg";


try {
  final result = await Amplify.Storage.uploadFile(
      local: file,
      key: fileName);
  return result.key;
}catch(e){
  throw e;
}


}

Future<String> getProfileImageUrl(String fileKey) async{

  try{

    final result = await Amplify.Storage.getUrl(key: fileKey);
    return result.url;


  }catch(e){
    print(e);
    throw e;

  }


}

Future<String> getProfileImageByUser(User user) async{

 List<String> partsOfMail = user.mail!.split("@");
  var fileName =  partsOfMail[0]+"_profile_image"+".jpg";

  try{
    final result = await Amplify.Storage.getUrl(key: fileName);
    return result.url;
  }catch(e){
    print(e);
    throw e;
  }

}

Future<void> _deleteImageFromCache(String path) async {
 String url = await getProfileImageUrl(path);
  await CachedNetworkImage.evictFromCache(url);
}

}