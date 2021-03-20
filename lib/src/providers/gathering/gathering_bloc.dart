import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_challange/src/helpers/helpers.dart';
import 'package:flutter_challange/src/screens/feed/feed_screen.dart';
import 'package:flutter_challange/src/screens/gathering/add_gathering_screen.dart';
import 'package:flutter_challange/src/screens/gathering/detail_gathering_screen.dart';
import 'package:flutter_challange/src/widgets/the_loader.dart';
import 'package:provider/provider.dart';

class GatheringBloc extends ChangeNotifier {
  BuildContext _context;

  CustomLoader loader = CustomLoader();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  setSelectedIndex(int val) {
    _selectedIndex = val;
    notifyListeners();
  }

  GatheringBloc() {}

  didMount(context) {
    _context = context;
  }

  gatheringClicked() {
    Navigator.of(_context).pushNamed(DetailGatheringScreen.routeName);
  }

  addGatheringClicked() {
    Navigator.of(_context).pushNamed(AddGatheringScreen.routeName);
  }
}
