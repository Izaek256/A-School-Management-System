import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:frontend/widgets/cards/dashboard_stat_card.dart';
import 'package:frontend/widgets/app_bar/app_bar.dart';
import 'package:frontend/widgets/navigation/side_navigation.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const SideNavigation(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Welcome Section
              const Text(
                'Good morning, Admin',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Here\'s what\'s happening today',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              
              // Stats Cards
              const Row(
                children: [
                  Expanded(
                    child: DashboardStatCard(
                      title: 'Total Students',
                      value: '1,248',
                      icon: Icons.school,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: DashboardStatCard(
                      title: 'Total Teachers',
                      value: '86',
                      icon: Icons.person,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Expanded(
                    child: DashboardStatCard(
                      title: 'Monthly Revenue',
                      value: '\$24,560',
                      icon: Icons.attach_money,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: DashboardStatCard(
                      title: 'Attendance Rate',
                      value: '92.5%',
                      icon: Icons.check_circle,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Charts Section
              const Text(
                'Attendance Trend',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    minX: 0,
                    maxX: 6,
                    minY: 0,
                    maxY: 6,
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          const FlSpot(0, 3),
                          const FlSpot(1, 4),
                          const FlSpot(2, 5),
                          const FlSpot(3, 4),
                          const FlSpot(4, 5),
                          const FlSpot(5, 4),
                          const FlSpot(6, 5),
                        ],
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 4,
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.blue.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Payments Chart
              const Text(
                'Monthly Payments',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: BarChart(
                  BarChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    barGroups: [
                      BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 5, color: Colors.blue)]),
                      BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 4, color: Colors.blue)]),
                      BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 6, color: Colors.blue)]),
                      BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 3, color: Colors.blue)]),
                      BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 5, color: Colors.blue)]),
                      BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 4, color: Colors.blue)]),
                      BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 6, color: Colors.blue)]),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Announcements
              const Text(
                'Recent Announcements',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.campaign, color: Colors.blue),
                      title: Text('School Holiday'),
                      subtitle: Text('December 25th - January 1st'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.event, color: Colors.green),
                      title: Text('Parent-Teacher Meeting'),
                      subtitle: Text('November 20th, 2023'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.update, color: Colors.orange),
                      title: Text('System Maintenance'),
                      subtitle: Text('November 25th, 2023'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}