import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/farm_plot.dart';
import 'package:couldai_user_app/models/plot_status.dart';

class FarmPlotWidget extends StatelessWidget {
  final FarmPlot plot;
  final bool isSelected;
  final VoidCallback onTap;

  const FarmPlotWidget({
    super.key,
    required this.plot,
    required this.isSelected,
    required this.onTap,
  });

  Color _getColorForStatus(PlotStatus status) {
    switch (status) {
      case PlotStatus.empty:
        return Colors.brown[700]!;
      case PlotStatus.planted:
        return Colors.green[600]!;
      case PlotStatus.fertilized:
        return Colors.yellow[600]!;
      default:
        return Colors.grey;
    }
  }

  IconData _getIconForStatus(PlotStatus status) {
    switch (status) {
      case PlotStatus.planted:
        return Icons.grass;
      case PlotStatus.fertilized:
        return Icons.eco;
      default:
        return Icons.texture;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: _getColorForStatus(plot.status),
          border: isSelected ? Border.all(color: Colors.blue, width: 3) : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Icon(
            _getIconForStatus(plot.status),
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
        ),
      ),
    );
  }
}
