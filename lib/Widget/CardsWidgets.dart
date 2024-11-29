import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scorers/Bloc/LeagueLogo/league_logo_bloc.dart';
import 'package:scorers/Bloc/LeagueLogo/league_logo_bloc.dart';
import 'package:scorers/Bloc/MatchBloc/match_bloc.dart';
import 'package:scorers/Models/BestPlayerModel.dart';
import 'package:scorers/Models/IncidentModel.dart';
import 'package:scorers/Widget/Component.dart';

// PastMatchCard
class PastMatchCard extends StatelessWidget {

  final Uint8List FTeamLog;
  final Uint8List STeamLog;
  final String FTeamName;
  final String STeamName;
  final String FTeamScore;
  final String STeamScore;
  final String FMname;
  final String Week;
  final String Status;
  final String dateTime;

  PastMatchCard({

    required this.FTeamLog,
    required this.STeamLog,
    required this.FTeamName,
    required this.STeamName,
    required this.FTeamScore,
    required this.STeamScore,
    required this.FMname,
    required this.Week,
    required this.Status,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Color(0xFF008F8F),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      BlocBuilder<LeagueLogoBloc, LeagueLogoState>(
                        builder: (context, state) {
                          if(state is LeagueLogoLoading){
                            return CircularProgressIndicator();
                          }

                          if(state is LeagueLogoLoaded) {
                            Uint8List Tlogo = base64Decode(state.leagueLogo.data);
                            return SizedBox(
                              height: 40,
                              width: 40,
                              child: Image.memory(Tlogo),
                            );
                          }else{
                            return Text("Erorr");
                          }
                        },
                      ),
                      SizedBox(
                        width: 180,
                        child: CustomWidget.CText(
                          FMname,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Flexible(
                    child: CustomWidget.CText(Week,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.memory(FTeamLog),
                      ),
                      CustomWidget.CText(FTeamName,
                          style: TextStyle(color: Colors.black))
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      CustomWidget.CText(dateTime,
                          style: TextStyle(
                            color: Colors.black45,
                          )),
                      Row(
                        children: [
                          CustomWidget.CText(FTeamScore,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          CustomWidget.CText("-",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          CustomWidget.CText(STeamScore,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ],
                      ),
                      CustomWidget.CText(Status,
                          style:
                          TextStyle(color: Colors.black45, fontSize: 12)),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.memory(STeamLog),
                      ),
                      CustomWidget.CText(STeamName,
                          style: TextStyle(color: Colors.black))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//PlayerOfTheMatchCard
class PlayerOfTheMatchCard extends StatelessWidget {
  final String PlayerName;
  final String TeamName;
  final Uint8List TeamLog;
  final Uint8List PlayerImage;
  final String Point;

  PlayerOfTheMatchCard({required this.PlayerName,
    required this.TeamLog,
    required this.PlayerImage,
    required this.Point,
    required this.TeamName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Color(0xFF008F8F),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: CustomWidget.CText(
                  "Player Of The Match",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: SizedBox(
                          height: 70,
                          width: 80,
                          child: Image.memory(PlayerImage),
                        ),
                      ),
                      Column(
                        children: [
                          CustomWidget.CText(PlayerName,
                              style: TextStyle(
                                color: Colors.black,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: Image.memory(TeamLog),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomWidget.CText(TeamName,
                                  style: TextStyle(color: Colors.black))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF008F8F),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      padding:
                      EdgeInsets.only(top: 3, bottom: 3, left: 7, right: 8),
                      child: CustomWidget.CText(Point,
                          style: TextStyle(color: Colors.white)))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// PenaltyShootoutCard
class PenaltyShootoutCard extends StatelessWidget {
  // final String STeamName;
  // // final String FTeamName;
  final Uint8List FTeamLog;
  final Uint8List STeamLog;
  final int penalties; // Total penalties
  final int FTsuccessCount;
  final int STsuccessCount;

  PenaltyShootoutCard({
    // required this.FTeamName,
    required this.FTeamLog,
    required this.FTsuccessCount,
    required this.STsuccessCount,
    required this.STeamLog,
    required this.penalties,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Color(0xFF008F8F),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: CustomWidget.CText(
                  "Penalty Shootout",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        // Team Info Column
                        Column(
                          children: [
                            CustomWidget.CText("(${FTsuccessCount})",
                                style: TextStyle(
                                    color: FTsuccessCount > STsuccessCount
                                        ? Colors.green
                                        : Colors.red)),
                            SizedBox(height: 10),
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: Image.memory(FTeamLog),
                            ),
                          ],
                        ),

                        // Spacer between team info and the ListView
                        SizedBox(width: 5),

                        // Horizontal ListView for Goal and Fail Results wrapped with Expanded
                        Expanded(
                          // Wrap the ListView in Expanded to take available space
                          child: Container(
                            color: Colors.yellow.withOpacity(0.4),
                            padding: EdgeInsets.all(8),
                            height: 60,
                            // Height of the container that holds the horizontal list
                            child: ListView.builder(
                              scrollDirection:
                              Axis.horizontal, // Horizontal scroll
                              itemCount:
                              penalties, // Number of items in the list
                              itemBuilder: (context, index) {
                                // Retrieve the data for the current item
                                return _buildPenaltyResult(
                                  penalties,
                                  FTsuccessCount,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          CustomWidget.CText("(${STsuccessCount})",
                              style: TextStyle(
                                  color: STsuccessCount > FTsuccessCount
                                      ? Colors.green
                                      : Colors.red)),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.memory(STeamLog),
                          ),
                        ],
                      ),

                      // Horizontal ListView for Goal and Fail Results
                      SizedBox(
                          width: 5), // Spacer between player info and ListView

                      Expanded(
                        child: Container(
                          color: Colors.redAccent.withOpacity(0.4),
                          padding: EdgeInsets.all(8),
                          height: 60,
                          // Height of the container that holds the horizontal list
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          // Half the screen width
                          child: ListView.builder(
                            scrollDirection:
                            Axis.horizontal, // Horizontal scroll
                            itemCount:
                            STsuccessCount, // Number of items in the list
                            itemBuilder: (context, index) {
                              // Retrieve the data for the current item
                              return _buildPenaltyResult(
                                penalties,
                                STsuccessCount,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPenaltyResult(int totalPenalties, int successCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Display success icons based on the successCount
        for (int i = 0; i < successCount; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 24,
            ),
          ),

        if (successCount < totalPenalties)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(
              Icons.cancel,
              color: Colors.red,
              size: 24,
            ),
          ),
      ],
    );
  }

  Widget _buildGoalFailResult(IconData icon, String result) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0),
      child: Column(
        children: [
          Icon(icon,
              color: result == 'Goal' ? Colors.green : Colors.red, size: 18),
          SizedBox(height: 5),
          Text(result,
              style: TextStyle(
                  color: result == 'Goal' ? Colors.green : Colors.red,
                  fontSize: 13)),
        ],
      ),
    );
  }
}

class MatchStatusCard extends StatelessWidget {
  final List<Player> player;
  final List<PlayerIn> playerIn;
  final List<PlayerOut> playerOut;
  final List<Incident> incidents;
  final Uint8List hTeamLog;
  final Uint8List aTeamLog;
  final Uint8List PlayerImage;

  const MatchStatusCard({Key? key,
    required this.player,
    required this.playerIn,
    required this.playerOut,
    required this.incidents,
    required this.hTeamLog,
    required this.aTeamLog,
    required this.PlayerImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter for penalty shootout incidents
    final penaltyShootouts = incidents
        .where((incident) => incident.incidentType == "penaltyShootout")
        .toList();

    // Filter incidents for penalty shootouts

// Filter incidents for yellow cards, red cards, and regular goal scores
    final cardsAndGoals = incidents
        .where((incident) =>
    incident.incidentType == "card" || incident.incidentType == "goal")
        .toList();





    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Color(0xFF008F8F),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.memory(hTeamLog),
                    ),
                    CustomWidget.CText(
                      "Penalty Shootout",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.memory(aTeamLog),
                    ),
                  ],
                )),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Icon(CupertinoIcons.clock),
                  status_Name_Icon(
                      text: "Penalties",
                      HScore: "${penaltyShootouts[0].homeScore}",
                      AScore: "${penaltyShootouts[0].awayScore}"),
                  Column(
                    children: List.generate(
                        (penaltyShootouts.length / 2).ceil(), (index) {
                      // Calculate the indices for the first and second player in each row
                      final firstIndex = index * 2;
                      final secondIndex = firstIndex + 1;

                      // Extract details for the first player
                      final firstIncident = penaltyShootouts[firstIndex];
                      final firstIsHome = firstIncident.isHome ??
                          false; // Determine if this is a home incident
                      final homePlayerNameFirst = firstIsHome
                          ? firstIncident.player?.shortName ?? "Unknown"
                          : "";
                      final homeIncidentClassFirst = firstIsHome
                          ? firstIncident.incidentClass ?? "Unknown"
                          : "";
                      final awayPlayerNameFirst = !firstIsHome
                          ? firstIncident.player?.shortName ?? "Unknown"
                          : "";
                      final awayIncidentClassFirst = !firstIsHome
                          ? firstIncident.incidentClass ?? "Unknown"
                          : "";

                      // Extract details for the second player, if it exists
                      final secondIncident =
                      secondIndex < penaltyShootouts.length
                          ? penaltyShootouts[secondIndex]
                          : null;
                      final secondIsHome = secondIncident?.isHome ??
                          false; // Determine if this is a home incident
                      final homePlayerNameSecond = secondIsHome
                          ? secondIncident?.player?.shortName ?? "Unknown"
                          : "";
                      final homeIncidentClassSecond = secondIsHome
                          ? secondIncident?.incidentClass ?? "Unknown"
                          : "";
                      final awayPlayerNameSecond = !secondIsHome
                          ? secondIncident?.player?.name ?? "Unknown"
                          : "";
                      final awayIncidentClassSecond = !secondIsHome
                          ? secondIncident?.incidentClass ?? "Unknown"
                          : "";

                      // Return a row containing the two penalty lists
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: secondIncident != null
                                  ? PenaltyList(
                                awayPlayerNameSecond,
                                awayIncidentClassSecond,
                                awayPlayerNameSecond,
                                homePlayerNameSecond,
                                homeIncidentClassSecond,
                                homePlayerNameSecond,
                                secondIsHome, // Pass the isHome flag
                              )
                                  : Container(), // Display empty container if there is no second player
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ...List.generate(
                                    4,
                                        (_) =>
                                        Text(
                                          ".",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        ),
                                  ),

                                  // CircleAvatar
                                  SizedBox(
                                    height: 25,
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xFF008F8F),
                                      child: Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ...List.generate(
                                    4,
                                        (_) =>
                                        Text(
                                          ".",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        ),
                                  ),
                                ],
                              ),
                            ), // Space between the two PenaltyLists

                            Expanded(
                              child: PenaltyList(
                                awayPlayerNameFirst,
                                awayIncidentClassFirst,
                                awayPlayerNameFirst,
                                homePlayerNameFirst,
                                homeIncidentClassFirst,
                                homePlayerNameFirst,
                                firstIsHome, // Pass the isHome flag
                              ),
                            ),
                          ]);
                    }),
                  ),
                ],
              ),
            ),



            Column(
              children: [
                status_Name_Icon(
                    text: "Penalties",
                    HScore: "${cardsAndGoals[0].homeScore}",
                    AScore: "${cardsAndGoals[0].awayScore}"),
                Column(
                  children:
                  List.generate((cardsAndGoals.length).ceil(), (index) {
                    // Extract details for the first player
                    final firstIncident = cardsAndGoals[index];
                    final firstIsHome = firstIncident.isHome ??
                        false; // Determine if this is a home incident
                    final PlayerName = firstIsHome
                        ? firstIncident.player?.shortName ?? "Unknown"
                        : "";
                    final IncidentClass = firstIsHome
                        ? firstIncident.incidentClass ?? "Unknown"
                        : "";
                    final IncidentType = firstIsHome
                        ? firstIncident.incidentType ?? "Unknown"
                        : "";
                    final reason =
                    firstIsHome ? firstIncident.reason ?? "Unknown" : "";

                    final MNumber = firstIsHome
                        ? firstIncident.time ?? 0
                        : 0;

                    // Return a row containing the two penalty lists
                    return RegularPlayerList(PlayerName, IncidentClass,
                        IncidentType, reason,MNumber, firstIsHome,);
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container RegularPlayerList(String PlayerName,
      String incidentClass,
      String incidentType,
      String reason,
      int MNumber,
      bool isHome,) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center the content
        children: [
          // Conditional rendering for home side
          isHome ?
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start, // Align to the start
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.memory(PlayerImage),
                  ),
                  SizedBox(width: 8), // Spacing
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomWidget.CText(
                          PlayerName,
                        ),
                        CustomWidget.CText(
                          "(${reason})",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  incidentType == "card" || incidentClass == "yellow"
                      ? Icon(Icons.sd_card_alert,
                      color: Colors.yellow, size: 20)
                      : incidentType == "goal" || incidentClass == "regular"
                      ? Icon(Icons.sports_baseball, size: 20)
                      : SizedBox(),
                ],
              ),
            ):  Expanded(flex: 2, child: SizedBox()),

          // Vertical dots and CircleAvatar section
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Align vertically
              children: [
                ...List.generate(
                  4,
                      (_) =>
                      Text(
                        ".",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                ),
                SizedBox(
                  height: 25,
                  child: CircleAvatar(
                    backgroundColor: Color(0xFF008F8F),
                    child: Text(
                      "${MNumber}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                ...List.generate(
                  4,
                      (_) =>
                      Text(
                        ".",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                ),
              ],
            ),
          ),


          // Conditional rendering for away side
          !isHome?
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // Align to the end
                children: [
                  incidentType == "card" || incidentClass == "yellow"
                      ? Icon(Icons.sd_card_alert,
                      color: Colors.yellow, size: 20)
                      : incidentType == "goal" || incidentClass == "regular"
                      ? Icon(Icons.sports_baseball, size: 20)
                      : SizedBox(),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomWidget.CText(
                          PlayerName,
                        ),
                        CustomWidget.CText(
                          "(${reason})",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.memory(PlayerImage),
                  ),
                ],
              ),
            ): Expanded(flex: 2, child: SizedBox()),
        ],
      ),
    );
  }

  Container PenaltyList(String AwayPlayerName,
      String AwayincidentClass,
      String AwayPlayer,
      String HomePlayerName,
      String HomeincidentClass,
      String HomePlayer,
      bool isHome, // Add this parameter
      ) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Display home or away content based on the isHome value
          Expanded(
            flex: 2,
            child: Row(
              children: [
                isHome
                    ? SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.memory(PlayerImage),
                )
                    : SizedBox(),
                SizedBox(width: 8),
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomWidget.CText(
                          isHome
                              ? HomePlayerName
                              : AwayPlayerName, // Adjust based on isHome
                        ),
                      ),
                      SizedBox(width: 8),
                      isHome
                          ? (HomeincidentClass == "scored"
                          ? Icon(Icons.sports_baseball, color: Colors.green)
                          : Icon(Icons.cancel_outlined, color: Colors.red))
                          : (AwayincidentClass == "scored"
                          ? Icon(Icons.sports_baseball, color: Colors.green)
                          : Icon(Icons.cancel_outlined, color: Colors.red)),
                      isHome
                          ? SizedBox()
                          : SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.memory(PlayerImage),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Additional widgets and sections
        ],
      ),
    );
  }


}

class status_Name_Icon extends StatelessWidget {
  String text;
  String HScore;
  String AScore;

  status_Name_Icon({
    super.key,
    required this.text,
    required this.HScore,
    required this.AScore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ...List.generate(
            2,
                (_) =>
                Text(
                  ".",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text("$text($HScore-$AScore)"),
            ),
          ),
        ],
      ),
    );
  }
}





class LiveMatchStandingsCard extends StatelessWidget {

  final List LiveData;


  LiveMatchStandingsCard({

    required this.LiveData,


  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Color(0xFF008F8F),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomWidget.CText(
                      "Live Match Standings",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Image.asset("assets/LALIGA.png"),
                        ),
                        Text(
                          "LaLiga",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                )),
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomWidget.CText(
                        "MP",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      CustomWidget.CText(
                        "W",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      CustomWidget.CText(
                        "D",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      CustomWidget.CText(
                        "L",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      CustomWidget.CText(
                        "GA",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      CustomWidget.CText(
                        "GF",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      CustomWidget.CText(
                        "P^",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Align items to the left
                      children: LiveData.map((result) {
                        // For each item in LiveData, build a widget
                        return _buildGoalFailResult(
                          result['result'],
                          result['TeamName'],
                          result['TeamLog'],
                          result['TeamMP'],
                          result['TeamW'],
                          result['TeamD'],
                          result['TeamL'],
                          result['TeamGA'],
                          result['TeamGF'],
                          result['TeamP'],
                        );
                      }).toList(), // Convert to a list of widgets
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGoalFailResult(String result,
      String TeamName,
      String TeamLog,
      String TeamMP,
      String TeamW,
      String TeamD,
      String TeamL,
      String TeamGA,
      String TeamGF,
      String TeamP,) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomWidget.CText(
                  result,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset(TeamLog),
                ),
                Container(
                  width: 90,
                  child: CustomWidget.CText(
                    TeamName,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Expanded(
              child: Wrap(
                spacing: 20, // Horizontal spacing between elements
                runSpacing: 10, // Vertical spacing between lines
                children: [
                  CustomWidget.CText(
                    TeamMP,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  CustomWidget.CText(
                    TeamW,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  CustomWidget.CText(
                    TeamD,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  CustomWidget.CText(
                    TeamL,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  CustomWidget.CText(
                    TeamGA,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  CustomWidget.CText(
                    TeamGF,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  CustomWidget.CText(
                    TeamP,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

          ],
        ),
        Divider()
      ],
    );
  }
}





class GamaInformationCard extends StatelessWidget {
  GamaInformationCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchBloc, MatchState>(
      builder: (context, state) {
        if (state is MatchLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is MatchLoaded) {
          final match = state.match;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Color(0xFF008F8F),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: CustomWidget.CText(
                      "Game Information",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      height: 280,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(CupertinoIcons.location_solid),
                            title: CustomWidget.CText("Venue"),
                            trailing: CustomWidget.CText(
                                match.data.event.venue.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          ),
                          ListTile(
                            leading: Icon(CupertinoIcons.calendar),
                            title: CustomWidget.CText("Date"),
                            trailing: CustomWidget.CText(
                                match.data.event.venue.slug,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          ),
                          ListTile(
                            leading: Icon(CupertinoIcons.time),
                            title: CustomWidget.CText("Time"),
                            trailing: CustomWidget.CText("Time",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          ),
                          ListTile(
                            leading: Icon(CupertinoIcons.person_alt),
                            title: CustomWidget.CText("Referee"),
                            trailing: CustomWidget.CText(
                                match.data.event.referee.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          ),
                          ListTile(
                            leading: Icon(Icons.stadium),
                            title: CustomWidget.CText("Stadium Capacity"),
                            trailing: CustomWidget.CText(
                                "${match.data.event.venue.capacity}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          );
        }
        if (state is MatchError) {
          return Text(state.message);
        } else {
          return Text("Error");
        }
      },
    );
  }


}
