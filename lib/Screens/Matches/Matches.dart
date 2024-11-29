import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:scorers/Screens/Matches/MatchDetails.dart';

import 'package:scorers/Widget/CardsWidgets.dart';

import 'package:scorers/Widget/SearchWidget.dart';

import '../../Bloc/MatchBloc/match_bloc.dart';
import '../../Widget/ChampionItem.dart';

class Matches extends StatefulWidget {
  const Matches({super.key});

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> with SingleTickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  final List<Map<String, String>> champions = [
    // EPL (English Premier League)
    {
      'name': 'EPL',
      'imageUrl': 'assets/EPL.png',
    },

    // La Liga
    {
      'name': 'La Liga',
      'imageUrl': 'assets/LALIGA.png',
    },

    // Serie A (Italy)
    {
      'name': 'Serie A',
      'imageUrl': 'assets/SerieA.png',
    },

    // Bundesliga (Germany)
    {
      'name': 'Bundesliga',
      'imageUrl': 'assets/BundesLiga.png',
    },

    // Ligue 1 (France)
    {
      'name': 'Ligue 1',
      'imageUrl': 'assets/Ligue1.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              child: MatchesTop(
                  searchController: _searchController, champions: champions)),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
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
                    text: "Live Matches",
                  ),
                  Tab(
                    text: "New Matches",
                  ),
                  Tab(
                    text: "Past Matches",
                  ),
                ],
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4 / 1.1,
            left: 0,
            right: 0,
            bottom: 0, // Ensure the TabBarView fills the space you want
            child: TabBarView(
              children: [
                Container(),
                Container(
                    child: ListView(
                  padding: EdgeInsets.zero,
                  children: [],
                )),
                Container(
                    child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => MatchDetails());
                      },
                      child: BlocBuilder<MatchBloc, MatchState>(
                        builder: (context, state) {
                          if (state is MatchLoading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is MatchLoaded) {
                            final match = state.match;
                            Uint8List HTeamLogo = base64Decode(
                                match.data.event.homeTeam.teamLogo);
                            Uint8List ATeamLogo = base64Decode(
                                match.data.event.awayTeam.teamLogo);
                            return PastMatchCard(
                                FTeamLog: HTeamLogo,
                                STeamLog: ATeamLogo,
                                FTeamName: match.data.event.homeTeam.shortName,
                                STeamName: match.data.event.awayTeam.shortName,
                                FTeamScore:
                                    "${match.data.event.hTeamScore.display}",
                                STeamScore:
                                    "${match.data.event.aTeamScore.display}",
                                FMname: match.data.event.season.name,
                                Week: "Game Week 15",
                                Status: "Full Time",
                                dateTime: match.data.event.season.year);
                          }
                          if (state is MatchError) {
                            return Text(state.message);
                          } else {
                            return Text("Error");
                          }
                        },
                      ),
                    )
                  ],
                ))
              ],
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }
}

class MatchesTop extends StatelessWidget {
  const MatchesTop({
    super.key,
    required TextEditingController searchController,
    required this.champions,
  }) : _searchController = searchController;

  final TextEditingController _searchController;
  final List<Map<String, String>> champions;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/field.png"),
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
              top: 50,
              left: 2,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.menu),
                      color: Colors.white,
                    ),
                    SizedBox(width: 25),
                    SizedBox(
                      child: Image.asset("assets/Slogo.png"),
                      width: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ResizableSearch(controller: _searchController),
                    )
                  ],
                ),
                // Wrap the ListView with an Expanded widget
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal, // Horizontal list
                    itemCount:
                        champions.length + 1, // Add 1 for the "Add" button
                    itemBuilder: (context, index) {
                      // Check if it's the first index (Add button)
                      if (index == 0) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(
                              16.0), // Rounded corners for the container
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(
                                      0xFF008F8F), // Circle background color
                                ),
                                padding: EdgeInsets.all(
                                    16.0), // Padding for the icon
                                child: Icon(
                                  CupertinoIcons.globe, // Globe icon
                                  size: 15,
                                  color: Colors.white, // Icon color
                                ),
                              ),
                              SizedBox(
                                  height: 8), // Space between icon and text
                              Text(
                                "All", // Text below the icon
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70, // Text color
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        // Access champion data starting from index 1
                        var champion = champions[index -
                            1]; // Shift the index by 1 to get the correct champion
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ChampionItem(
                            imageUrl: champion['imageUrl']!,
                            name: champion['name']!,
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
