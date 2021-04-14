import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_challange/src/constants/the_colors.dart';
import 'package:flutter_challange/src/constants/the_font_weight.dart';
import 'package:flutter_challange/src/helpers/helpers.dart';
import 'package:flutter_challange/src/providers/gathering/add_gathering_bloc.dart';
import 'package:flutter_challange/src/widgets/the_rounded_button.dart';
import 'package:flutter_challange/src/widgets/the_sized_box.dart';
import 'package:flutter_challange/src/widgets/the_text_field.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_widget.dart';

class AddGatheringScreen extends StatelessWidget {
  static const String routeName = '/add-gathering';

  @override
  Widget _body(BuildContext context, AddGatheringBloc bloc) {
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
            TheTextFieldRadius(
              labelText: 'Nama Group',
              controller: bloc.nameController,
            ),
            TheSizedBox.extraSmallVertical(),
            Text(
              'Tipe Arisan',
              style: TextStyle(
                color: TheColors.black,
                fontSize: 14,
                fontWeight: TheFontWeight.semiBold,
              ),
            ),
            DropdownButton<String>(
              isExpanded: true,
              value: bloc.groupModel.type,
              icon: const Icon(Icons.keyboard_arrow_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              hint: Text('Pilih'),
              underline: Container(
                height: 2,
                color: Colors.grey,
              ),
              onChanged: (String newValue) {
                bloc.setType(newValue);
              },
              items: <String>['Bebas', 'Konstan']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TheSizedBox.extraSmallVertical(),
            Text(
              'Jangka Waktu',
              style: TextStyle(
                color: TheColors.black,
                fontSize: 14,
                fontWeight: TheFontWeight.semiBold,
              ),
            ),
            DropdownButton<String>(
              isExpanded: true,
              value: bloc.groupModel.rangeTime == null
                  ? null
                  : (bloc.groupModel.rangeTime == 7 ? 'Perminggu' : 'Perbulan'),
              icon: const Icon(Icons.keyboard_arrow_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              hint: Text('Pilih'),
              underline: Container(
                height: 2,
                color: Colors.grey,
              ),
              onChanged: (String newValue) {
                bloc.setRangeTime(newValue == 'Perminggu' ? 7 : 30);
              },
              items: <String>['Perbulan', 'Perminggu']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TheSizedBox.extraSmallVertical(),
            // _entryField('Putaran Ke',
            //     controller: bloc.namaController,
            //     errorText: bloc.registerError.nama),
            TheSizedBox.extraSmallVertical(),

            TheTextFieldRadius(
              labelText: 'Uang Kas',
              controller: bloc.cashController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
            ),
            TheSizedBox.extraSmallVertical(),
            TheTextFieldRadius(
              labelText: 'Uang Konsumsi',
              controller: bloc.consumtionController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
            ),
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
    keyboardType = TextInputType.text,
  }) {
    return TheTextFieldRadius(
      labelText: labelText,
      hintText: labelText,
      controller: controller,
      obscureText: obscureText,
      errorText: errorText,
      keyboardType: keyboardType,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ], // Only numbers can be entered
    );
  }

  Widget _submitButton(BuildContext context, AddGatheringBloc bloc) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        width: MediaQuery.of(context).size.width,
        child: TheRoundedButton(title: 'Buat', onPressed: bloc.onSubmit));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<AddGatheringBloc>(context);
    bloc.didMount(context);

    return Scaffold(
      backgroundColor: TheColors.background,
      key: bloc.scaffoldKey,
      appBar: AppBar(
        title: customText(
          'Buat Group Arisan',
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
