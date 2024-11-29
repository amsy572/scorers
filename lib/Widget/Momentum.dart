import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scorers/Models/MatchStatsModel.dart';
import 'package:scorers/Widget/Component.dart';

import '../Bloc/MatchStats/match_stats_bloc.dart';
import '../Models/MomentumModel.dart';

class MomentumChart extends StatelessWidget {
  final List<GraphPoint> graphPoints;

  MomentumChart({required this.graphPoints});

  @override
  Widget build(BuildContext context) {
    return  Card(
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
                  "Live Match Momentum",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),

            // BlocBuilder<MatchStatsBloc, MatchStatsState>(
            //   builder: (context, state) {
            //     if (state is MatchStatsInitial) {
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (state is MatchStatsLoaded) {
            //       List<StatisticGroup> statisticGroup = state.matchStats.data.statistics;
            //       List<StatisticItem> graphPoint = statisticGroup[0].statisticsItems;
            //
            //       double homePossession = double.tryParse(graphPoint[0].home) ?? 0.0;
            //       double awayPossession = double.tryParse( graphPoint[0].away) ?? 0.0;
            //       return BallPossessionProgress(
            //         homePossession:homePossession,
            //         awayPossession:awayPossession,
            //       );
            //     } if(state is MatchStatsError){
            //       return Text(state.message);
            //     }
            //     else {
            //       return Center(
            //         child: Text('Error loading match stats'),
            //       );
            //     }
            //   },
            // ),

            Container(
              height: 300, // Set a fixed height
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: graphPoints
                          .map((point) => FlSpot(point.minute.toDouble(), point.value.toDouble()))
                          .toList(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  gridData: FlGridData(show: true),
                ),
              ),
            ),
          ],
        ),
    );
  }
}



class BallPossessionProgress extends StatelessWidget {
  final double homePossession;
  final double awayPossession;

  BallPossessionProgress({
    required this.homePossession,
    required this.awayPossession,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Ball Possession',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Home',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  LinearProgressIndicator(
                    value: homePossession / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    minHeight: 10,
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${homePossession.toStringAsFixed(2)}%',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Away',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  LinearProgressIndicator(
                    value: awayPossession / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    minHeight: 10,
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${awayPossession.toStringAsFixed(2)}%',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

