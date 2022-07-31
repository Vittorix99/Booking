



import 'package:bookingmobile2/Bloc/calendar_Bloc.dart';
import 'package:bookingmobile2/Bloc/profile_bloc.dart';

import 'package:bookingmobile2/Repos/data_repo.dart';
import 'package:bookingmobile2/Utils/exceptions.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/Prenotazione.dart';
import '../Models/Prenotazione.dart';
import '../Repos/prenotazioni_repo.dart';





class BookBloc extends Bloc<PrenotazioneEvent, PrenotazioneState> {

  BookBloc(PrenotazioneInitial prenotazioneInitial,
      { required this.datarepo, required this.prenotazioniRepo, required this.profileBloc})
      : super(prenotazioneInitial);

  PrenotazioneState get initialState => PrenotazioneInitial();
  final DataRepository datarepo;
  final PrenotazioniRepo prenotazioniRepo;
  final ProfileBloc profileBloc;


  @override
  Stream<PrenotazioneState> mapEventToState(PrenotazioneEvent event) async* {
    if (event is PrenotazioneStart) {
      yield PrenotazioneInitial();
    }
    else if (event is PrenotazioneSalaBuilding) {
      PrenotazioneState newstate = PrenotazioneState(
          prenotazione: event.state.prenotazione,
          isMoreDays: event.state.isMoreDays,
          days: event.state.days);
      //print(newstate.prenotazione!.salaID);
      yield  newstate;
    }
    else if (event is PrenotazioneBuilding) {
      PrenotazioneState newstate = PrenotazioneState(
          prenotazione: event.state.prenotazione,
          isMoreDays: event.state.isMoreDays,
          days: event.state.days);
    //  print(newstate.prenotazione!.salaID);
      yield newstate;
    }
    else if (event is PrenotazioneMoreDaysEvent) {
      PrenotazioneState newstate = event.state;
      newstate.isMoreDays = true;
      newstate.days = event.state.days;
      yield newstate;
    }
    else if (event is PrenotazioneToSubmit) {
      yield PrenotazioneSubmitting(prenotazione: state.prenotazione!);
      final Prenotazione pre = event.state.prenotazione!;
      PrenotazioneFinished newstate = PrenotazioneFinished(
          pre, event.state.days, event.state.isMoreDays);

      try {
       bool bookDone =  await this.prenotazioniRepo.addPrenotazione(newstate.prenotazione!);

      if(bookDone)  {
        this.profileBloc.add(AddPrenotazione(newstate.prenotazione!));
        yield newstate;
      }else{
        yield PrenotazioneFailed(state, "Impossibile effettuare prenotazione");
      }





      } catch (e) {
        print("Non è stato possibile effettuare la prenotazione");
        if (e is PrenotazioneNotValid)  yield PrenotazioneFailed(
            state, "Utente ha già una prenotazione per questo giorno");
        if(e is DateNotValid)  yield PrenotazioneFailed(
            state, "Impossibile effettuare una prenotazione per questa data");
         else yield PrenotazioneFailed(
              state, "Prenotazione non valida");
          throw e;
      }
    }

    else if (event is PrenotazioneSalaToSubmit) {
      yield PrenotazioneSubmitting(prenotazione: state.prenotazione!);
      final Prenotazione pre = event.state.prenotazione!;
      PrenotazioneFinished newstate = PrenotazioneFinished(
          pre, event.state.days, event.state.isMoreDays);

      try {
      bool isDone =  await this.prenotazioniRepo.addSalaPrenotazione(pre);

      if(isDone){
        this.profileBloc.add(AddPrenotazione(pre));
        yield newstate;
      }
      else{
        yield PrenotazioneFailed(
            state, "Sala già prenotata in questo orario");

       }
      } catch (e) {
        yield PrenotazioneFailed(
            state, "Impossibile prenotare la sala");
        throw e;

      }
    }
  }


    }


    class PrenotazioneEvent {
  PrenotazioneState state;
  PrenotazioneEvent(this.state);

}





class PrenotazioneState extends Equatable {
 Prenotazione? prenotazione;
 int? days;
bool? isMoreDays = false;

 PrenotazioneState({  this.prenotazione, this.days, this.isMoreDays});

 @override
  // TODO: implement props
  List<Object?> get props => [];

}



//Stati
class PrenotazioneInitial extends PrenotazioneState{
  PrenotazioneInitial( {Prenotazione? prenotazione}) : super(prenotazione: Prenotazione());

}
class PrenotazioneSubmitting extends PrenotazioneState{
  PrenotazioneSubmitting( {required Prenotazione prenotazione, int? days, bool? isMoreDays}) : super(prenotazione: prenotazione, days: days, isMoreDays: isMoreDays);
}


class PrenotazioneFinished extends PrenotazioneState{
  PrenotazioneFinished( Prenotazione prenotazione, int? days, bool? isMoreDays) : super(prenotazione: prenotazione, days: days, isMoreDays: isMoreDays);
}
class PrenotazioneFailed extends PrenotazioneState{
  String errore;
  PrenotazioneFailed(PrenotazioneState state, this.errore) : super(prenotazione: state.prenotazione, days: state.days, isMoreDays: state.isMoreDays);
}

//EVENTS
class PrenotazioneStart extends PrenotazioneEvent{
  PrenotazioneStart() : super(PrenotazioneState());

}
class PrenotazioneBuilding extends PrenotazioneEvent{
  PrenotazioneBuilding(PrenotazioneState newPrenotazioneState) : super(newPrenotazioneState);
}
class PrenotazioneToSubmit extends PrenotazioneEvent{
  PrenotazioneToSubmit(PrenotazioneState newPrenotazioneState) : super(newPrenotazioneState);
}
class PrenotazioneSalaToSubmit extends PrenotazioneEvent{
  PrenotazioneSalaToSubmit(PrenotazioneState newPrenotazioneState) : super(newPrenotazioneState);
}

class PrenotazioneMoreDaysEvent extends PrenotazioneEvent {
  PrenotazioneMoreDaysEvent(PrenotazioneState newPrenotazioneState)
      : super(newPrenotazioneState);
}
class PrenotazioneMoreDaysSubmit extends PrenotazioneEvent{
  PrenotazioneMoreDaysSubmit(PrenotazioneState newPrenotazioneState) : super(newPrenotazioneState);

}
class PrenotazioneSalaBuilding extends PrenotazioneEvent{
  PrenotazioneSalaBuilding(PrenotazioneState newPrenotazioneState) : super(newPrenotazioneState);
  }