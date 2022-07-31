

import 'dart:io';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:amazon_cognito_identity_dart_2/src/cognito_user.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:bookingmobile2/Models/ModelProvider.dart';
import 'package:bookingmobile2/Utils/constants.dart';

import '../Models/Office.dart';
import '../Models/Office.dart';
import '../Models/Postazione.dart';
import '../Models/Postazione.dart';
import '../Models/User.dart';
import '../Models/User.dart';
import '../Models/User.dart';
import '../Utils/exceptions.dart';

class DataRepository {
  List<Office> ufficiLocal = List<Office>.empty(growable: true);


  Future<User?> getUserByMail(String mail) async {
    try {



      final users = await Amplify.DataStore.query(
          User.classType, where: User.MAIL.eq(mail));


      final user = users.first;

      if (user.favorites == null) user.favorites = List.empty(growable: true);

      return user;
    } catch (e) {
      print(e);
      throw UserNotFoundException();
    }
  }


  Future<Office?> getOfficeById(String id) async {
    try {
      Office? localOf;
      if (ufficiLocal.isNotEmpty) localOf = ufficiLocal
          .where((element) => element.id == id)
          .toList()
          .first;
      if (localOf != null) return localOf;

      final office = await Amplify.DataStore.query(
          Office.classType, where: Office.ID.eq(id));

      if (office == null || office.isEmpty) return mockedOffice
          .where((element) => element.id == id)
          .toList()
          .first;
      return office.first;
    } catch (e) {
      throw e;
    }
  }

  Future<Sala?> getSalaById(String id) async {
    try {
      Sala? localOf;


      final sala = await Amplify.DataStore.query(
          Sala.classType, where: Sala.ID.eq(id));

      //  if(sala == null || sala.isEmpty) return  mockedOffice.where((element) => element.id==id).toList().first;
      return sala.first;
    } catch (e) {
      print("Non è stata trovata alcuna sala con questo id");
      throw e;
    }
  }

  Future<Postazione?> getPostazioneById(String id) async {
    try {
      final postazione = await Amplify.DataStore.query(
          Postazione.classType, where: Postazione.ID.eq(id));

      //  if(sala == null || sala.isEmpty) return  mockedOffice.where((element) => element.id==id).toList().first;
      return postazione.first;
    } catch (e) {
      print("Non è stata trovata alcuna sala con questo id");
      throw e;
    }
  }

  Future<User?> getUserById(String userId) async {
    try {
      final users = await Amplify.DataStore.query(
          User.classType, where: User.ID.eq(userId));

      return users.isNotEmpty ? users.first : null;
    } catch (e) {
      throw e;
    }
  }

  Future<User> createUser(
      {required String userId, required String mail,}) async {
    final newUser = User(id: userId, mail: mail,);

    try {
      await Amplify.DataStore.save(newUser);

      return newUser;
    } catch (e) {
      throw e;
    }
  }

  Future<User?> updateUser(User updated) async {
    try {
      await Amplify.DataStore.save(updated);
      return updated;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<Office>> getOfficesByCity(String city) async {
    try {
      //List<Office>? offices = ufficiLocal.where((element) => element.city == city).toList();

      //  if(offices.isNotEmpty) return offices;
      List<Office>? offices = await Amplify.DataStore.query(
          Office.classType, where: Office.CITY.eq(city));

      /*if(offices.isEmpty){
      List<Office> of = mockedOffice.where((element) => element.city == city).toList();
      return of;

    }*/
      //   this.ufficiLocal.addAll(offices);

      return offices;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<Postazione?> getPostazioneByIdAndOffice(String officeId,
      String postazionlabel) async {
    try {
      var res = await Amplify.DataStore.query(Postazione.classType,
          where: Postazione.POSTAZIONE.eq(postazionlabel).and(
              Postazione.OFFICEID.eq(officeId)));


      if (res.isEmpty) {
        Office? of = await this.getOfficeById(officeId);

        if (of == null) throw OfficeNotFoundException();
        Postazione pos = Postazione(
            postazione: postazionlabel, officeID: officeId);
        await Amplify.DataStore.save(pos);
        return pos;
      } else {
        if (res.first.postazione != null &&
            res.first.officeID != null) {
          return res.first;
        }

        throw Exception("Non è stato possibile caricare la postazione");
      }
    } catch (e) {
      print("Non è stato possibile caricare la postazione");
      throw e;
    }
  }

  Future<List<Sala>> getSaleByOffice(String id) async {
    try {
      List<Sala> sale = await Amplify.DataStore.query(
          Sala.classType, where: Sala.SALAOFFICEID.eq(id));
      if (sale.isNotEmpty) return sale;


      return [];
    } catch (e) {
      print("Non è stato possibile trovare le sale");
      throw e;
    }
  }

  Future<void> addPreferitoToUser(User user, String preferito) async {
    List<String> favorites = List.of(user.favorites!, growable: true);

    try {
      favorites.add(preferito);
      user.favorites = favorites;
      await Amplify.DataStore.save(user);
    } catch (e) {
      print("non è stato possibile salvare il preferito");
      print(e);
      throw e;
    }
  }

  Future<void> deletePreferitoFromUser(User user, String preferito) async {
    try {
      user.favorites!.removeWhere((element) => element == preferito);
      await Amplify.DataStore.save(user);
    } catch (e) {
      throw e;
    }
  }

  Future<List<Office>> getAllFavoritesOffice(List<String> favorites) async {
    List<Office> res = [];
    favorites = favorites.toSet().toList();

    try {
      for (int i = 0; i < favorites.length; i++) {
        Office? of = await this.getOfficeById(favorites.elementAt(i));
        if (of != null) res.add(of);
      }
      return res;
    } catch (e) {
    return [];
    }
  }

  Future<List<Postazione>?> getPostazioniofOffice(Office of) async {
    try {
      var postazioni = await Amplify.DataStore.query(
          Postazione.classType, where: Postazione.OFFICEID.eq(of.id));





      if ( postazioni.length > of.capienza ) {

        await eliminaPostazioniDuplicate(postazioni);
        postazioni =  await Amplify.DataStore.query(Postazione.classType, where: Postazione.OFFICEID.eq(of.id));

      }


      return postazioni;



    } catch (e) {
      print("Impossibile caricare le postazini");
      throw e;
    }
  }

  Future<List<Postazione>> createPostazioniofOffice(Office of) async {
    var pos = await Amplify.DataStore.query(
        Postazione.classType, where: Postazione.OFFICEID.eq(of.id));
    try {
      pos.forEach((element) async {
        await Amplify.DataStore.delete(element);
      });
    } catch (c) {
      print("Impossibile cancellare le postazioni");
      throw c;
    }
    List<Postazione> postazioni = List.empty(growable: true);
    try {
      await Amplify.DataStore.start();
      for (int i = 0; i < of.capienza; i++) {
        String posLabel = "P" + i.toString();
        Postazione pos = Postazione(
            officeID: of.id, postazione: posLabel, );

        await Amplify.DataStore.save(pos);



        postazioni.add(pos);
      }
      return postazioni;
    } catch (e) {
      print("Non è stato possibile salvare le postazioni");
      var pos = await Amplify.DataStore.query(
          Postazione.classType, where: Postazione.OFFICEID.eq(of.id));
      try {
        pos.forEach((element) async {
          await Amplify.DataStore.delete(element);
        });
        return List.empty();
      } catch (c) {
        print("Impossibile cancellare le postazioni");
        throw c;
      }
    }
  }

  Future<void> eliminaPostazioniDuplicate(List<Postazione> postazioni) async {
    List<Postazione> singles = List.empty(growable: true);
    List<Postazione> duplicates = List.empty(growable: true);
    try {
      for (int i = 0; i < postazioni.length; i++) {
        if (singles
            .where((element) =>
        element.postazione == postazioni[i].postazione &&
            element.officeID == postazioni[i].officeID)
            .isEmpty) {
          singles.add(postazioni[i]);
        }
        else {
          duplicates.add(postazioni[i]);
        }
      }

      duplicates.forEach((element) async {
        await Amplify.DataStore.delete(element);
      });
    } catch (e) {
      print("Impossibile eliminare i duplicati");
      throw e;
    }
  }

  Future<void> addPostazione(Postazione pos) async{
    try{
      await Amplify.DataStore.save(pos);

    }catch(e){
print("Impossibile aggiungere postazione");
throw e;

    }

  }

 Future<User?> createCognitoUser(CognitoUser cognitoUser,  List<CognitoUserAttribute> attributi) async{


    User user = User(mail: cognitoUser.username);

    for(CognitoUserAttribute attr in attributi){
      if(attr.getName() == "given_name") user.name = attr.value;
      if(attr.getName() =="family_name") user.surname = attr.value;

      try{
        await Amplify.DataStore.save(user);
        return user;

      }catch(e){
        print("Impossibile salvare l'utente");
        rethrow;
      }

    }



 }

 Future<List<Office>> getAllOffices() async {
    try{
      List<Office> offices = await Amplify.DataStore.query(Office.classType);

      return offices;




    }catch(e){
      print("Impossibile trovare uffici");
      throw e;

    }




 }

  Future saveOffice(Office of) async {
    try{


      createPostazioniofOffice(of);
      await Amplify.DataStore.save(of);
    }catch(e){
      throw e;

    }


  }

  Future<void> deleteOffice(Office office) async{

    try{
      List<Sala> sale = await Amplify.DataStore.query(Sala.classType, where: Sala.SALAOFFICEID.eq(office.id));
      sale.forEach((element) async { await Amplify.DataStore.delete(element); });
      List<Prenotazione> pren = await Amplify.DataStore.query(Prenotazione.classType, where: Prenotazione.OFFICEID.eq(office.id));
      pren.forEach((element) async { await Amplify.DataStore.delete(element); });





      await Amplify.DataStore.delete(office);
    }catch(e){
      throw e;
    }


  }

  Future<void> updateOffice(Office newOffice) async {
    try{
      await Amplify.DataStore.save(newOffice);



    }catch(e){

      print("Impossinile aggiornare l'ufficio");
      throw e;



    }



  }








}