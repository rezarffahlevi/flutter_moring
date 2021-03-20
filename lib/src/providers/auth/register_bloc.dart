import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_challange/src/helpers/preferences_base.dart';
import 'package:flutter_challange/src/helpers/validators.dart';
import 'package:flutter_challange/src/models/auth/login_model.dart';
import 'package:flutter_challange/src/models/auth/register_model.dart';
import 'package:flutter_challange/src/screens/home/home_root_screen.dart';
import 'package:flutter_challange/src/screens/user/profile_screen.dart';
import 'package:flutter_challange/src/services/auth_sevice.dart';
import 'package:flutter_challange/src/widgets/custom_widget.dart';
import 'package:flutter_challange/src/widgets/the_loader.dart';

class RegisterBloc extends ChangeNotifier {
  BuildContext _context;

  CustomLoader loader = CustomLoader();
  final formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  final _repository = AuthService();
  LoginResponseModel _auth;
  LoginModel loginModel = LoginModel();
  RegisterModel registerModel = RegisterModel();
  RegisterModel registerError = RegisterModel();

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final telpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RegisterBloc() {
    namaController.addListener(() {
      registerModel.nama = namaController.text;
      registerError.nama = Validators.required('Nama', namaController.text);
      notifyListeners();
    });
    emailController.addListener(() {
      registerModel.email = emailController.text;
      registerError.email = Validators.required('Email', emailController.text);
      notifyListeners();
    });
    telpController.addListener(() {
      registerModel.telp = telpController.text;
      registerError.telp = Validators.required('No Telp', telpController.text);
      notifyListeners();
    });
    passwordController.addListener(() {
      registerModel.password = passwordController.text;
      registerError.confirmPassword =
          registerModel.password != registerModel.confirmPassword
              ? 'Password dan ulangi password tidak sama'
              : null;
      registerError.password =
          registerModel.password != registerModel.confirmPassword
              ? 'Password dan ulangi password tidak sama'
              : null;
      registerError.password =
          Validators.required('Password', passwordController.text);
      registerError.confirmPassword =
          registerModel.password != registerModel.confirmPassword
              ? 'Password dan ulangi password tidak sama'
              : null;
      notifyListeners();
    });
    confirmPasswordController.addListener(() {
      registerModel.confirmPassword = confirmPasswordController.text;
      registerError.confirmPassword =
          registerModel.password != registerModel.confirmPassword
              ? 'Password dan ulangi password tidak sama'
              : null;
      registerError.password =
          registerModel.password != registerModel.confirmPassword
              ? 'Password dan ulangi password tidak sama'
              : null;
      registerError.confirmPassword = Validators.required(
          'Ulangi Password', confirmPasswordController.text);
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
        loginModel.email = registerModel.email;
        loginModel.password = registerModel.password;

        final response = await _repository.postRegister(registerModel);
        _auth = response;
        loader.hideLoader();
        if (_auth.status) {
          await Prefs.setAuth(loginModel);
          await Prefs.setToken(_auth.token);
          Navigator.of(_context).popUntil((route) => route.isFirst);
          Navigator.pushReplacementNamed(_context, HomeRootScreen.routeName);
        } else {
          customSnackBar(scaffoldKey, _auth.message,
              backgroundColor: Colors.redAccent);
        }
      }
    } catch (e) {
      loader.hideLoader();
      print("ERROR SUBMIT ==> $e");
      customSnackBar(scaffoldKey, 'Something went wrong!',
          backgroundColor: Colors.redAccent);
    }
  }

  validate() {
    int validated = 6;

    if (Validators.isNull(registerModel.nama)) {
      registerError.nama = Validators.required('Nama', registerModel.nama);
      validated--;
    }
    if (Validators.isNull(registerModel.email)) {
      registerError.email = Validators.required('Email', registerModel.email);
      validated--;
    }
    if (Validators.isNull(registerModel.telp)) {
      registerError.telp = Validators.required('Telp', registerModel.telp);
      validated--;
    }
    if (registerModel.password != registerModel.confirmPassword) {
      registerError.password = 'Password dan ulangi password tidak sama';
      validated--;
    }
    if (Validators.isNull(registerModel.password)) {
      registerError.password =
          Validators.required('Password', registerModel.password);
      validated--;
    }
    if (Validators.isNull(registerModel.confirmPassword)) {
      registerError.confirmPassword = Validators.required(
          'Konfirmasi Password', registerModel.confirmPassword);
      validated--;
    }

    notifyListeners();
    return validated == 6;
  }

  clearEmailValue() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => emailController.clear());
  }

  clearPasswordValue() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => passwordController.clear());
  }
}
