import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_challange/src/constants/the_colors.dart';
import 'package:flutter_challange/src/constants/the_font_weight.dart';
import 'package:flutter_challange/src/helpers/helpers.dart';
import 'package:flutter_challange/src/helpers/validators.dart';
import 'package:flutter_challange/src/providers/auth/register_bloc.dart';
import 'package:flutter_challange/src/widgets/the_rounded_button.dart';
import 'package:flutter_challange/src/widgets/the_sized_box.dart';
import 'package:flutter_challange/src/widgets/the_text_field.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_widget.dart';

class WinnerSettinScreen extends StatelessWidget {
  static const String routeName = '/winner-setting';

  @override
  Widget _body(BuildContext context, RegisterBloc bloc) {
    final dimension = MediaQuery.of(context).size;
    return Container(
      // height: dimension.height - 88,

      padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
      child: Form(
        key: bloc.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _entryField('Nama / Email',
                controller: bloc.namaController,
                errorText: bloc.registerError.nama),
            TheSizedBox.extraSmallVertical(),
            _entryField('Tanggal Arisan',
                controller: bloc.namaController,
                errorText: bloc.registerError.nama,
                enabled: false,
                onTap: () => Helpers.showDatePicker(
                    context, 'Tanggal Arisan', (val) => print(val),
                    defaultDateTime: DateTime.now())),
            TheSizedBox.extraSmallVertical(),
            _entryField('Tempat',
                controller: bloc.namaController,
                errorText: bloc.registerError.nama,
                isArea: true),
            TheSizedBox.extraSmallVertical(),
            _entryField('Notes',
                controller: bloc.namaController,
                errorText: bloc.registerError.nama,
                isArea: true),
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
    bool isArea = false,
    bool enabled = true,
    Function onTap,
  }) {
    return TheTextFieldRadius(
      labelText: labelText,
      hintText: labelText,
      controller: controller,
      obscureText: obscureText,
      errorText: errorText,
      isArea: isArea,
      enabled: enabled,
      onClicked: onTap,
    );
  }

  Widget _submitButton(BuildContext context, RegisterBloc bloc) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        width: MediaQuery.of(context).size.width,
        child: TheRoundedButton(title: 'Simpan', onPressed: bloc.onSubmit));
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
          'Pemenang Arisan',
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
