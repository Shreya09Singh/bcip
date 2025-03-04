import 'package:flutter/material.dart';

class ConnectionProvider with ChangeNotifier {
  String _connectionstatus = 'connected';
  String get connectionStatus => _connectionstatus;

  void setConnectionStatus(String status) {
    _connectionstatus = status;
    notifyListeners();
  }

  //get button color based on the status
  Color get buttonColor {
    switch (_connectionstatus) {
      case 'connected':
        return Colors.green;
      case 'pause':
        return Colors.blue;

      case 'stop':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color get iconColor => buttonColor;

  IconData get statusIcon {
    switch (_connectionstatus) {
      case 'connected':
        return Icons.headset_mic;
      case 'pause':
        return Icons.pause_circle_filled;
      case 'stop':
        return Icons.headset_off;
      default:
        return Icons.headset_mic;
    }
  }
}
