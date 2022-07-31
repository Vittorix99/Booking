import 'package:bookingmobile2/Bloc/prenotazione_flow_bloc.dart';
import 'package:bookingmobile2/Cubit/session_cubit.dart';
import 'package:bookingmobile2/Models/ModelProvider.dart';
import 'package:bookingmobile2/Utils/google_auth.dart';
import 'package:bookingmobile2/Views/account_page.dart';
import 'package:bookingmobile2/Views/cambio_pass_page.dart';
import 'package:bookingmobile2/Views/details_account_page.dart';
import 'package:bookingmobile2/Views/first_page.dart';
import 'package:bookingmobile2/Views/gestisci_uffici_page.dart';
import 'package:bookingmobile2/Views/home_page.dart';
import 'package:bookingmobile2/Views/login_page.dart';
import 'package:bookingmobile2/Cubit/session_state.dart';
import 'package:bookingmobile2/Views/sale_riunioni_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Views/cities_page.dart';
import 'Views/confirm_reservation.dart';
import 'Views/reservation_page.dart';
import 'Views/select_office_page.dart';
import 'Views/select_workstation_page.dart';

class AppNavigator extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<BookBloc, PrenotazioneState>(
      builder: (context, state) {
        return BlocBuilder<SessionCubit, SessionState>(
          builder: (context, sessionstate) {
            return Navigator(
              pages: [
                if(sessionstate is UnknownSessionState)
                  MaterialPage(child: FirstPage()),
                if(sessionstate is Unauthenticated)
                  MaterialPage(child: LoginPage()),

                if(sessionstate is GoogleAuth)

                  MaterialPage(child: WebViewGoogleFacebook("Google")),

                if(sessionstate is Authenticated && sessionstate.user!=null)

                  MaterialPage(child: HomePage()),



                if(sessionstate is Authenticated && sessionstate.user == null)
                  MaterialPage(child: LoginPage()),










              ],
              onPopPage: (route, result)=>route.didPop(result),
              onGenerateRoute: CustomRoute.generateRoute,



            );
          }
        );
      }
    );
  }


  
  
  
}

class CustomRoute{
  static Route<dynamic> generateRoute(RouteSettings settings){
    var args = null;
    if(settings.arguments!=null)
     args = settings.arguments as Map;

    switch(settings.name){
      case '/': return MaterialPageRoute(builder: (_)=> FirstPage());
      case '/login': return MaterialPageRoute(builder: (_)=> LoginPage());






      case '/account': return MaterialPageRoute(builder: (_)=> AccountPage());
      case '/home':

        return MaterialPageRoute(settings:settings,builder: (_)=> HomePage());

      case '/account':
        return MaterialPageRoute(builder: (_)=> AccountPage());

      case '/account_details':
        return MaterialPageRoute(builder: (_)=> AccountDetailsPage());


      case '/cities':  return MaterialPageRoute(settings:settings,builder: (_)=> CityPage(args['isSalabook'] as bool));

      case '/offices':

          return MaterialPageRoute( settings: RouteSettings(name: "offices"),
              builder: (_) => SelectOfficePage(city: args['city'] as String, isSalaBook: args['isSalabook'] as bool,));

        return MaterialPageRoute(settings:settings,builder: (_) => HomePage());

      case '/reservation':  return MaterialPageRoute(settings:RouteSettings(name: "reservation"),builder: (_)=> ReservationPage(args['office'] as Office));
      case '/reservation_sala':  return MaterialPageRoute(settings:RouteSettings(name: "reservation_sala"),builder: (_)=> ReservationSalaPage(args['sala'] as Sala, args['office'] as Office));

      case '/workstation': return MaterialPageRoute(settings:settings,builder: (_)=> SelectPostazionePage(args['office'] as Office));
      case '/sala_page': return MaterialPageRoute(settings:settings,builder: (_)=> SelectSalaPage(city: args['city'] as String, office: args['office'] as Office));
      case '/confirmation': return MaterialPageRoute(settings:settings,builder: (_)=> ConfirmReservationPage());
      case '/confirmation_sala': return MaterialPageRoute(settings:settings,builder: (_)=> ConfirmReservationSalaPage());
      case '/password': return MaterialPageRoute(settings:settings,builder: (_)=> CambioPasswordPage());
      case '/gestisci_uffici': return MaterialPageRoute(settings:settings,builder: (_)=> GestisciUffici());

      default: return MaterialPageRoute(builder: (_)=> HomePage());

    }



  }


}
