import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:scorers/Bloc/BestPlayersBloc/best_player_bloc.dart';
import 'package:scorers/Bloc/Incidents/incidents_bloc.dart';
import 'package:scorers/Bloc/LeagueLogo/league_logo_bloc.dart';
import 'package:scorers/Bloc/MatchBloc/match_bloc.dart';
import 'package:scorers/Bloc/MatchStats/match_stats_bloc.dart';
import 'package:scorers/Bloc/Momentum/momentum_bloc.dart';
import 'package:scorers/Bloc/PlayerImage/player_image_bloc.dart';
import 'package:scorers/Bloc/VideoHL/video_hl_bloc.dart';
import 'package:scorers/Screens/Dashboard/Dashboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,  // Lock to portrait mode
    // DeviceOrientation.landscapeRight,  // Uncomment to lock to landscape mode
    // DeviceOrientation.landscapeLeft,  // Uncomment for landscape support
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        // Match Json file bloc Provider
        BlocProvider(
        create:(context) => MatchBloc()..add(LoadMatchEvent()),),

        // BestPlayer Json file bloc Provider
        BlocProvider(
          create:(context) => BestPlayerBloc()..add(LoadBestPlayerEvent()),),

        // Incidents Json file bloc Provider
        BlocProvider(
          create:(context) => IncidentsBloc()..add(LoadIncidentsEvent()),),

        // PlayerImage Json file bloc Provider
        BlocProvider(
          create:(context) => PlayerImageBloc()..add(LoadPlayerImageEvent()),),

        // LeagueLogo Json file bloc Provider
        BlocProvider(
          create:(context) => LeagueLogoBloc()..add(LoadLeagueLogoEvent()),),


        // MatchStats Json file bloc Provider
        BlocProvider(
          create:(context) => MatchStatsBloc()..add(LoadMatchStatsEvent()),),

        // Momentum Json file bloc Provider
        BlocProvider(
          create:(context) => MomentumBloc()..add(LoadMomentumEvent()),),

        // VideoHighLight Json file bloc Provider
        BlocProvider(
          create:(context) => VideoHlBloc()..add(LoadVideoHlEvent()),),


      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Dashboard(),
      ),
    );
  }
}

