
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bookingmobile2/Models/Postazione.dart';
import 'package:bookingmobile2/Utils/constants.dart';

import '../Models/Office.dart';
import '../Models/Prenotazione.dart';
import '../Models/Prenotazione.dart';
import '../Models/Sala.dart';
import '../Utils/exceptions.dart';

class PrenotazioniRepo{
  List<Prenotazione> _prenotazioni = [];



  Future<bool> isDayFull(DateTime date , Office of) async{
    //To Add API  methods async
    List<Prenotazione> pren = [];

    pren =  await Amplify.DataStore.query(Prenotazione.classType, where: Prenotazione.OFFICEID.eq(of.id).and(Prenotazione.DATE.eq(TemporalDate(date)).and(Prenotazione.SALAID.eq(null))));


    try {
      if (pren.length < of.capienza) return false;
      if (pren.length == of.capienza) return true;
      if (pren.length > of.capienza) throw OltreCapienzaException();

      return false;
    } catch (e) {
      if (e is OltreCapienzaException) {
        print("Ufficio più pieno del previsto");

      }
      throw e;
    }
  }

  Future<List<bool>?> fetchFullDays(List<DateTime> days, Office of) async{
    List<bool> isFullDays = List<bool>.filled(days.length, false, growable: false);

    try {
      for (int i = 0; i < days.length; i++) {
        isFullDays[i] = await this.isDayFull(days[i], of);
      }
      return isFullDays;
    }catch(e){
      print("Impossibile recuperare giorni pieni");
      throw e;
    }


  }
  Future<List<bool>?> fetchSalaFullDays(List<DateTime> days, Sala sala) async{
    List<bool> isFullDays = List<bool>.filled(days.length, false, growable: false);

    try {
      for (int i = 0; i < days.length; i++) {
        isFullDays[i] = await this.isSalaDayFull(days[i], sala);
      }
      return isFullDays;
    }catch(e){
      print("Impossibile recuperare giorni pieni");
      throw e;
    }


  }


  Future<bool> isSalaDayFull(DateTime date , Sala sala) async{
    //To Add API  methods async
    List<Prenotazione> pren = [];

    pren =  await Amplify.DataStore.query(Prenotazione.classType, where: Prenotazione.SALAID.eq(sala.id).and(Prenotazione.DATE.eq(TemporalDate(date))));
int ore = 0;

for(int i = 0; i<pren.length;i++){
  ore+= pren[i].endTime! -  pren[i].startTime!;

}

if(ore > Constant.WORKING_HOURS){
  return true;
}else return false;


  }



  Future<bool> isSalaFree(DateTime date, String salaid, int inizio, int fine) async {
    try { //To Add API  methods async
      List<Prenotazione> pren = await Amplify.DataStore.query(
          Prenotazione.classType, where: Prenotazione.SALAID.eq(salaid).and(
          Prenotazione.DATE.eq(TemporalDate(date))));
      for (int i = 0; i < pren.length; i++) {
        if(inizio == pren[i].endTime! ) return true;
        if(fine == pren[i].startTime!) return true;
        if (inizio >= pren[i].startTime! && inizio <= pren[i].endTime!)
          return false;

        if (fine >= pren[i].startTime! && fine <=pren[i].endTime!)
          return false;


      }
      return true;
    }catch(e){
      print("Impossibile vedere se la sala è occupata o meno");
      return false;

    }
  }



  Future<void> isPrenotazionValida(String name, String surname, String mail, DateTime date) async{


final List<Prenotazione> res = await Amplify.DataStore.query(Prenotazione.classType, where: Prenotazione.MAIL.eq(mail).and(Prenotazione.SALAID.eq(null)).and(Prenotazione.NAME.eq(name)).and(Prenotazione.DATE.eq(TemporalDate(date))).and(Prenotazione.SURNAME.eq(surname)));

 if(res.isNotEmpty) throw PrenotazioneNotValid();


 if(date.compareTo(DateTime.now())<=0) throw DateNotValid();

 return ;



  }

  Future<bool> addPrenotazione(Prenotazione prenotazione) async{
// To ADD API methods async
    try {
      var ofs =  await Amplify.DataStore.query(Office.classType, where: Office.ID.eq(prenotazione.officeID!));
      Office of = ofs.first;
      bool isFull = await isDayFull(
          prenotazione.date!, of);
      if (!isFull) {
        try {
          await isPrenotazionValida(
              prenotazione.name!, prenotazione.surname!, prenotazione.mail!,
              prenotazione.date!);
        }catch(e){
          throw e;
        }

        await Amplify.DataStore.save(prenotazione);
        return true;
      } else {
        print("Ufficio pieno per questo giorno");
        throw UfficioPienoException();
      }
    }catch(e){

      print("Non è possibile effettuare la prenotazione");
    throw e;


    }

  }

  Future<List <Prenotazione>?> fetchPrenotazioniOfUser(String mail) async {

    try{

      List<Prenotazione> res = await Amplify.DataStore.query(Prenotazione.classType, where: Prenotazione.MAIL.eq(mail));

   for(int i = 0; i<res.length;i++){
        if(res[i].postazione == null){
         if(res[i].salaID== null) {
           var pos = await Amplify.DataStore.query(Postazione.classType,
               where: Postazione.ID.eq(res[i].prenotazionePostazioneId));
           res[i].postazione = pos.first;
         }
        }
      }

      return res;
    }catch(e){
      print(e);

      print("Impossibile trovare prenotazioni del'utennte");
      throw e;
    }


  }

  Future<void> deletePrenotazione(Prenotazione pre) async {
    try{
     await Amplify.DataStore.delete(pre);

     _prenotazioni.removeWhere((element) => element.id==pre.id);
    }catch(e){

      print("Impossibile eliminare la prenotazione");
      throw e;

    }



  }

 Future<List<Prenotazione>> getPrenotazioniByDayAndOffice(Office office, DateTime? date) async{
  if(date== null) return [];
    TemporalDate tdate = TemporalDate(date);

    try{


      List<Prenotazione> prenotazioni = await Amplify.DataStore.query(Prenotazione.classType, where: Prenotazione.DATE.eq(tdate).and(Prenotazione.OFFICEID.eq(office.id)));
      if(prenotazioni.isEmpty){
        return [];
      }
      return prenotazioni;

    }catch(e){
      print(e);
      throw e;

    }



  }

  Future<bool> addSalaPrenotazione(Prenotazione prenotazione) async {

try {



  bool isFree = await isSalaFree(
      prenotazione.date!, prenotazione.salaID!, prenotazione.startTime!,
      prenotazione.endTime!);

  if (isFree == true){

    await Amplify.DataStore.save(prenotazione);
    return true;
  }

 return false;
}catch(e){
print("non è stato possibile effettuare la prenotazione nella sala");
throw e;

}




  }

  Future<void> deletePrenotazioniOfOfice(Office office) async{

    try{

      List<Prenotazione> pren = await Amplify.DataStore.query(Prenotazione.classType, where: Prenotazione.OFFICEID.eq(office.id));

      pren.forEach((element) async { await Amplify.DataStore.delete(element); });



    }catch(e){
      throw e;
    }




  }






}