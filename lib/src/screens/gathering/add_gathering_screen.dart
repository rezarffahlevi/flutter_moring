import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_challange/src/constants/the_colors.dart';
import 'package:flutter_challange/src/helpers/helpers.dart';
import 'package:flutter_challange/src/helpers/validators.dart';
import 'package:flutter_challange/src/providers/auth/register_bloc.dart';
import 'package:flutter_challange/src/widgets/the_rounded_button.dart';
import 'package:flutter_challange/src/widgets/the_sized_box.dart';
import 'package:flutter_challange/src/widgets/the_text_field.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_widget.dart';

class AddGatheringScreen extends StatelessWidget {
  static const String routeName = '/add-gathering';

  @override
  Widget _body(BuildContext context, RegisterBloc bloc) {
    final dimension = MediaQuery.of(context).size;
    return Container(
      // height: dimension.height - 88,

      padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
      child: Form(
        key: bloc.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _entryField('Nama Group',
                controller: bloc.namaController,
                errorText: bloc.registerError.nama),
            TheSizedBox.extraSmallVertical(),
            _entryField('Tipe Arisan',
                controller: bloc.emailController,
                errorText: bloc.registerError.email),
            TheSizedBox.extraSmallVertical(),
            _entryField('Jangka Waktu',
                controller: bloc.telpController,
                errorText: bloc.registerError.telp),
            TheSizedBox.extraSmallVertical(),
            _entryField('Uang Kas',
                controller: bloc.passwordController,
                obscureText: true,
                errorText: bloc.registerError.password),
            TheSizedBox.extraSmallVertical(),
            _entryField('Uang Konsumsi',
                controller: bloc.confirmPasswordController,
                obscureText: true,
                errorText: bloc.registerError.confirmPassword),
            TheSizedBox.extraSmallVertical(),
            _submitButton(context, bloc),
          ],
        ),
      ),
    );
  }

  Widget _entryField(
    String labelText, {
    TextEditingController controller,
    String errorText,
    bool obscureText = false,
  }) {
    return TheTextFieldRadius(
      labelText: labelText,
      hintText: labelText,
      controller: controller,
      obscureText: obscureText,
      errorText: errorText,
    );
  }

  Widget _submitButton(BuildContext context, RegisterBloc bloc) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        width: MediaQuery.of(context).size.width,
        child: TheRoundedButton(title: 'Buat', onPressed: bloc.onSubmit));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RegisterBloc>(context);
    bloc.didMount(context);

    return Scaffold(
      backgroundColor: TheColors.background,
      key: bloc.scaffoldKey,
      appBar: AppBar(
        title: customText(
          'Tambah Group Arisan',
          context: context,
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: TheColors.primary,
        centerTitle: true,
      ),
      body: SafeArea(
          child: GestureDetector(
              onTap: () => Helpers.dismissKeyboard(context),
              child: SingleChildScrollView(child: _body(context, bloc)))),
    );
  }
}
