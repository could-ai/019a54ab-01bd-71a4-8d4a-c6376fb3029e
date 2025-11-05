import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/farm_plot.dart';
import 'package:couldai_user_app/models/plot_status.dart';
import 'package:couldai_user_app/widgets/farm_plot_widget.dart';

class FarmScreen extends StatefulWidget {
  const FarmScreen({super.key});

  @override
  _FarmScreenState createState() => _FarmScreenState();
}

class _FarmScreenState extends State<FarmScreen> {
  final int farmWidth = 10;
  final int farmHeight = 10;
  late List<FarmPlot> farmPlots;
  FarmPlot? selectedPlot;
  String selectedAction = 'Plant';

  @override
  void initState() {
    super.initState();
    _initializeFarm();
  }

  void _initializeFarm() {
    farmPlots = List.generate(farmWidth * farmHeight, (index) => FarmPlot(id: index));
  }

  void _onPlotTapped(FarmPlot plot) {
    setState(() {
      selectedPlot = plot;
    });
  }

  void _performAction() {
    if (selectedPlot == null) return;

    setState(() {
      final index = farmPlots.indexWhere((p) => p.id == selectedPlot!.id);
      if (index != -1) {
        switch (selectedAction) {
          case 'Plant':
            if (farmPlots[index].status == PlotStatus.empty) {
              farmPlots[index].status = PlotStatus.planted;
            }
            break;
          case 'Fertilize':
            if (farmPlots[index].status == PlotStatus.planted) {
              farmPlots[index].status = PlotStatus.fertilized;
            }
            break;
          case 'Harvest':
            if (farmPlots[index].status == PlotStatus.fertilized) {
              farmPlots[index].status = PlotStatus.empty;
            }
            break;
        }
        selectedPlot = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Farm'),
        backgroundColor: Colors.brown[400],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.green[800],
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: farmWidth,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: farmPlots.length,
                itemBuilder: (context, index) {
                  final plot = farmPlots[index];
                  return FarmPlotWidget(
                    plot: plot,
                    isSelected: selectedPlot?.id == plot.id,
                    onTap: () => _onPlotTapped(plot),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blueGrey[100],
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton('Plant', Icons.grass),
                      _buildActionButton('Fertilize', Icons.compost),
                      _buildActionButton('Harvest', Icons.agriculture),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: selectedPlot != null ? _performAction : null,
                    child: Text('Perform Action: $selectedAction'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String action, IconData icon) {
    bool isSelected = selectedAction == action;
    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          selectedAction = action;
        });
      },
      icon: Icon(icon),
      label: Text(action),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.green[700] : Colors.grey,
        foregroundColor: Colors.white,
      ),
    );
  }
}
