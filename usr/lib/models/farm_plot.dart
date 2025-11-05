import 'package:couldai_user_app/models/plot_status.dart';

class FarmPlot {
  final int id;
  PlotStatus status;

  FarmPlot({required this.id, this.status = PlotStatus.empty});
}
