import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scorers/Bloc/BestPlayersBloc/best_player_bloc.dart';
import 'package:scorers/Bloc/MatchBloc/match_bloc.dart';
import 'package:scorers/Bloc/PlayerImage/player_image_bloc.dart';
import 'package:scorers/Bloc/VideoHL/video_hl_bloc.dart';

import 'package:scorers/Models/MatchModel.dart';

import 'package:scorers/Widget/CardsWidgets.dart';
import 'package:scorers/Widget/Component.dart';
import 'package:scorers/Widget/Momentum.dart';

import 'package:scorers/Widget/VideoPlayer.dart';

import '../../Bloc/Incidents/incidents_bloc.dart';
import '../../Bloc/Momentum/momentum_bloc.dart';
import '../../Models/IncidentModel.dart';
import '../../Models/VideoHighlightModel.dart';
import '../../Widget/ChampionItem.dart';

class MatchDetails extends StatefulWidget {
  const MatchDetails({super.key});

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails>
    with SingleTickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this);
    super.initState();
  }

  final LiveMatch = [
    {
      'result': '2',
      'TeamName': 'Barcelona',
      'TeamLog': 'assets/Barce.png',
      'TeamMP': '8',
      'TeamW': '8',
      'TeamD': '0',
      'TeamL': '0',
      'TeamGA': '1',
      'TeamGF': '19',
      'TeamP': '24',
    },
    {
      'result': '4',
      'TeamName': 'Real Madrid',
      'TeamLog': 'assets/Rmadrid.png',
      'TeamMP': '8',
      'TeamW': '2',
      'TeamD': '2',
      'TeamL': '4',
      'TeamGA': '1',
      'TeamGF': '16',
      'TeamP': '20',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MatchBloc, MatchState>(
        builder: (context, state) {
          if (state is MatchLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MatchLoaded) {
            final match = state.match;
            Uint8List HTeamLogo =
                base64Decode(match.data.event.homeTeam.teamLogo);
            Uint8List ATeamLogo =
                base64Decode(match.data.event.awayTeam.teamLogo);
            return Stack(
              children: [
                Positioned(
                    top: 0,
                    child: MatchesTop(
                      searchController: _searchController,
                    )),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.4,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Color(0xFF002929),
                    width: MediaQuery.of(context)
                        .size
                        .width, // Make the TabBar take the full screen width
                    child: TabBar(
                      unselectedLabelColor: Colors.white60,
                      labelColor: Colors.white,
                      tabs: [
                        Tab(
                          text: "Oerview",
                        ),
                        Tab(
                          text: "Line-up",
                        ),
                        Tab(
                          text: "Statistics",
                        ),
                        Tab(
                          text: "Matches",
                        ),
                      ],
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.6 / 1.3,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  // Ensure the TabBarView fills the space you want
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Container(
                          child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BlocBuilder<VideoHlBloc, VideoHlState>(
                              builder: (context, state) {
                                if (state is VideoHlLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (state is VideoHlLoaded) {
                                  List<Highlight> highlight =
                                      state.videoHL.data.highlights;
                                  String videoUrl = highlight[0].url;
                                  String thumbnailUrl =
                                      highlight[0].thumbnailUrl;

                                  return CustomYouTubePlayer(
                                    videoUrl: videoUrl,
                                    thumbnailUrl: thumbnailUrl,
                                  );
                                }
                                if (state is VideoHlError) {
                                  return Text(state.message);
                                } else {
                                  return Text("Error");
                                }
                              },
                            ),
                          ),
                          BestPlayersList(match: match),
                          PenaltyShootoutCard(
                            FTeamLog: ATeamLogo,
                            FTsuccessCount:
                                match.data.event.aTeamScore.penalties,
                            STsuccessCount:
                                match.data.event.hTeamScore.penalties,
                            penalties: 5,
                            STeamLog: HTeamLogo,
                          ),
                          BlocBuilder<MomentumBloc, MomentumState>(
                            builder: (context, state) {
                              if (state is MomentumLoading) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (state is MomentumLoaded) {
                                return MomentumChart(
                                    graphPoints:
                                        state.momentum.data.graphPoints);
                              } else if (state is MomentumError) {
                                print(state.message);
                                return Center(child: Text(state.message));
                              }
                              return Center(child: Text("Press to load data"));
                            },
                          ),
                          BlocBuilder<IncidentsBloc, IncidentsState>(
                            builder: (context, state) {
                              if (state is IncidentsLoading) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (state is IncidentsLoaded) {
                                List<Incident> incidents =
                                    state.incident.data.incidents;

                                // Get the list of non-null playerIn entries
                                List<PlayerIn?> playerInList = incidents
                                    .map((incident) => incident.playerIn)
                                    .toList();
                                List<PlayerIn> filteredPlayerInList =
                                    playerInList
                                        .where((playerIn) => playerIn != null)
                                        .cast<PlayerIn>()
                                        .toList();

                                List<PlayerOut?> playerOutList = incidents
                                    .map((incident) => incident.playerOut)
                                    .toList();
                                List<PlayerOut> filteredPlayerOutList =
                                    playerOutList
                                        .where((playerout) => playerout != null)
                                        .cast<PlayerOut>()
                                        .toList();

                                List<Player?> playerList = incidents
                                    .map((incident) => incident.player)
                                    .toList();
                                List<Player> filteredPlayerList = playerList
                                    .where((player) => player != null)
                                    .cast<Player>()
                                    .toList();

                                return BlocBuilder<PlayerImageBloc,
                                    PlayerImageState>(
                                  builder: (context, state) {
                                    if (state is PlayerImageLoading) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    if (state is PlayerImageLoaded) {
                                      Uint8List PleyerImg =
                                          base64Decode(state.playerImage.data);
                                      return MatchStatusCard(
                                        player: filteredPlayerList,
                                        playerOut: filteredPlayerOutList,
                                        incidents: incidents,
                                        playerIn: filteredPlayerInList,
                                        hTeamLog: HTeamLogo,
                                        aTeamLog: ATeamLogo,
                                        PlayerImage: PleyerImg,
                                      );
                                    }
                                    if (state is PlayerImageError) {
                                      return Text(state.message);
                                    } else {
                                      return Text("Error");
                                    }
                                  },
                                );
                              } else if (state is IncidentsError) {
                                print(state.message);
                                return Center(child: Text(state.message));
                              }
                              return Center(child: Text("Press to load data"));
                            },
                          ),
                          LiveMatchStandingsCard(LiveData: LiveMatch),
                          GamaInformationCard()
                        ],
                      )),
                      Container(),
                      Container(),
                      Container(),
                    ],
                  ),
                ),
              ],
            );
          }
          if (state is MatchError) {
            return Text(state.message);
          } else {
            return Text("Error");
          }
        },
      ),
    );
  }
}

class BestPlayersList extends StatelessWidget {
  const BestPlayersList({
    super.key,
    required this.match,
  });

  final MatchModel match;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BestPlayerBloc, BestPlayerState>(
      builder: (context, state) {
        if (state is BestPlayerLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is BestPlayerLoaded) {
          final player = state.player;

          Uint8List HTeamLogo =
              base64Decode(match.data.event.homeTeam.teamLogo);
          Uint8List ATeamLogo =
              base64Decode(match.data.event.awayTeam.teamLogo);
          return Container(
            height: 300,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemCount: player.data.length,
                itemBuilder: (context, index) {
                  final bp = player.data[index];
                  return BlocBuilder<PlayerImageBloc, PlayerImageState>(
                    builder: (context, state) {
                      if (state is PlayerImageLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is PlayerImageLoaded) {
                        Uint8List PleyerImg =
                            base64Decode(state.playerImage.data);
                        return Column(
                          children: [
                            PlayerOfTheMatchCard(
                                PlayerName: bp.hbPlayer.player.shortName,
                                TeamLog: HTeamLogo,
                                PlayerImage: PleyerImg,
                                Point: bp.hbPlayer.value,
                                TeamName: match.data.event.homeTeam.shortName),
                            PlayerOfTheMatchCard(
                                PlayerName: bp.abPlayer.player.shortName,
                                TeamLog: ATeamLogo,
                                PlayerImage: PleyerImg,
                                Point: bp.abPlayer.value,
                                TeamName: match.data.event.awayTeam.shortName),
                          ],
                        );
                      }
                      if (state is PlayerImageError) {
                        return Text(state.message);
                      } else {
                        return Text("Error");
                      }
                    },
                  );
                }),
          );
        }
        if (state is BestPlayerError) {
          return Text(state.message);
        } else {
          return Text("Error");
        }
      },
    );
  }
}

class MatchesTop extends StatelessWidget {
  const MatchesTop({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchBloc, MatchState>(
      builder: (context, state) {
        if (state is MatchLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MatchLoaded) {
          final match = state.match;
          Uint8List HTeamLogo =
              base64Decode(match.data.event.homeTeam.teamLogo);
          Uint8List ATeamLogo =
              base64Decode(match.data.event.awayTeam.teamLogo);
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/DBg.png"),
                  fit: BoxFit.cover,
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.black, // Full black for testing
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Container(
                color: Color(0xE5002929).withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                    left: 2,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.navigate_before),
                            color: Colors.white,
                          ),
                          // SizedBox(width: 15),

                          CustomWidget.CText(
                            "Match Details",
                            style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () {
                              // Navigator.pop(context);
                            },
                            icon: Icon(Icons.notifications_none_outlined),
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Image.memory(HTeamLogo),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomWidget.CText(
                                      match.data.event.homeTeam.shortName,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomWidget.CText("R.Lewandowski 11'",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 15)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomWidget.CText("J.Felix 25'",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 15)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomWidget.CText("J.Cancelo 33'",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 15)),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: Row(
                                      children: [
                                        CustomWidget.CText(
                                            "${match.data.event.hTeamScore.display}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 35)),
                                        CustomWidget.CText("-",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 35)),
                                        CustomWidget.CText(
                                            "${match.data.event.aTeamScore.display}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 35)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomWidget.CText(
                                      "(${match.data.event.hTeamScore.aggregated}-${match.data.event.aTeamScore.aggregated})",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 15)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomWidget.CText("Full Time",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 15)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Icon(
                                    Icons.sports_basketball,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 35,
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Image.asset("assets/SerieA.png"),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Image.memory(ATeamLogo),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomWidget.CText(
                                      match.data.event.awayTeam.shortName,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomWidget.CText("Y.Couto 4'",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 15)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomWidget.CText("A.Garcia 15'",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 15)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomWidget.CText("I.Martin 27",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 15)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ));
        }
        if (state is MatchError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Text("Error");
        }
      },
    );
  }
}
