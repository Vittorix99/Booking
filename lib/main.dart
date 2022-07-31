import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:bookingmobile2/Bloc/login_bloc.dart';

import 'package:bookingmobile2/Bloc/profile_bloc.dart';
import 'package:bookingmobile2/Cubit/session_cubit.dart';
import 'package:bookingmobile2/Models/ModelProvider.dart';
import 'package:bookingmobile2/Repos/prenotazioni_repo.dart';
import 'package:bookingmobile2/Repos/data_repo.dart';
import 'package:bookingmobile2/Repos/login_repo.dart';
import 'package:bookingmobile2/Repos/storage_repo.dart';
import 'package:bookingmobile2/Views/cities_page.dart';
import 'package:bookingmobile2/Views/confirm_reservation.dart';
import 'package:bookingmobile2/Views/home_page.dart';
import 'package:bookingmobile2/Views/login_page.dart';
import 'package:bookingmobile2/Views/reservation_page.dart';
import 'package:bookingmobile2/Views/select_office_page.dart';
import 'package:bookingmobile2/Views/select_workstation_page.dart';
import 'package:bookingmobile2/amplifyconfiguration.dart';
import 'package:bookingmobile2/app_navigator.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/prenotazione_flow_bloc.dart';
import 'Cubit/auth_cubit.dart';
import 'Models/Prenotazione.dart';
import 'Utils/loading_page.dart';
import 'Views/first_page.dart';

void main() {
  runApp( MyApp());
}
class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
bool isAmplifyConfigured = false;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _configureAmplify();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context)=> AuthRepository()),
          RepositoryProvider(create: (context)=> DataRepository()),
          RepositoryProvider(create: (context)=> StorageRepository()),
          RepositoryProvider(create: (context)=> PrenotazioniRepo())

        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context)=> ProfileBloc(dataRepo: context.read<DataRepository>(), storageRepo: context.read<StorageRepository>(), prenotazioniRepo: context.read<PrenotazioniRepo>(), authRepo: context.read<AuthRepository>(), )  ),

            BlocProvider(create: (BuildContext context)=> SessionCubit(authRepo: context.read<AuthRepository>(), dataRepo: context.read<DataRepository>(), profileBloc: context.read<ProfileBloc>(), prenotazioniRepo: context.read<PrenotazioniRepo>())),



            BlocProvider(create: (context) => AuthCubit(sessionCubit: BlocProvider.of<SessionCubit>(context))),
            BlocProvider(create: (context) => LoginBloc(authRepo: context.read<AuthRepository>(), authCubit: BlocProvider.of<AuthCubit>(context))),


            BlocProvider(create: (BuildContext context)=> BookBloc(PrenotazioneInitial(), datarepo:context.read<DataRepository>(), prenotazioniRepo: context.read<PrenotazioniRepo>(),profileBloc:context.read<ProfileBloc>()  )),

          ],
          child: MaterialApp(
            onGenerateRoute: CustomRoute.generateRoute,

            theme: ThemeData(
            fontFamily: "Poppins"

          ),
          home:  isAmplifyConfigured? AppNavigator(): LoadingView()
          ),
        ),
    );
  }

Future<void> _configureAmplify () async {

    try{
      await Amplify.addPlugins([AmplifyAuthCognito(),
                                AmplifyDataStore(modelProvider: ModelProvider.instance),
                                AmplifyAPI(),
                                 AmplifyStorageS3()]);
      await Amplify.configure(amplifyconfig);
      setState(() {
        this.isAmplifyConfigured = true;
      });

    }catch(e){
      print(e);
    }

}

}










