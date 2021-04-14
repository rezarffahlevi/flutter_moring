import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_challange/src/helpers/preferences_base.dart';
import 'package:flutter_challange/src/helpers/validators.dart';
import 'package:flutter_challange/src/models/auth/login_model.dart';
import 'package:flutter_challange/src/models/auth/register_model.dart';
import 'package:flutter_challange/src/models/gathering/gathering_group_model.dart';
import 'package:flutter_challange/src/screens/home/home_root_screen.dart';
import 'package:flutter_challange/src/screens/user/profile_screen.dart';
import 'package:flutter_challange/src/services/auth_sevice.dart';
import 'package:flutter_challange/src/widgets/custom_widget.dart';
import 'package:flutter_challange/src/widgets/the_loader.dart';

class AddGatheringBloc extends ChangeNotifier {
  BuildContext _context;

  CustomLoader loader = CustomLoader();
  final formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  final _repository = AuthService();
  GatheringGroupModel groupModel = GatheringGroupModel();

  final nameController = TextEditingController();
  final cashController = TextEditingController();
  final consumtionController = TextEditingController();

  setType(String type) {
    groupModel.type = type;
    notifyListeners();
  }

  setRangeTime(int rangeTime) {
    groupModel.rangeTime = rangeTime;
    notifyListeners();
  }

  AddGatheringBloc() {
    nameController.addListener(() {
      groupModel.name = nameController.text;
      notifyListeners();
    });
    cashController.addListener(() {
      groupModel.cash = int.tryParse(cashController.text) ?? groupModel.cash;
      notifyListeners();
    });
    consumtionController.addListener(() {
      groupModel.consumtion =
          int.tryParse(consumtionController.text) ?? groupModel.consumtion;
      notifyListeners();
    });
  }

  didMount(context) {
    _context = context;
  }

  onSubmit() async {
    try {
      if (await validate()) {
        loader.showLoader(_context);

        loader.hideLoader();
      }
    } catch (e) {
      loader.hideLoader();
      print("ERROR SUBMIT ==> $e");
      customSnackBar(scaffoldKey, 'Something went wrong!',
          backgroundColor: Colors.redAccent);
    }
  }

  validate() {
    int validated = 1;

    if (Validators.isNull(groupModel.name)) {
      // groupError.name = Validators.required('Nama Group', groupModel.name);
      validated--;
    }

    notifyListeners();
    return validated == 1;
  }
}
