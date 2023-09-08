import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monitoring/source/router/string.dart';
import 'package:monitoring/source/services/Auth/cubit/auth_session_cubit.dart';
import 'package:monitoring/source/widget/copyright.dart';
import 'package:monitoring/source/widget/customButton.dart';
import 'package:monitoring/source/widget/customDialog.dart';
import 'package:monitoring/source/widget/customForm2.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  bool hidePassword = true;
  final formkey = GlobalKey<FormState>();

  void login() {
    if (formkey.currentState!.validate()) {
      BlocProvider.of<AuthSessionCubit>(context).login(controllerEmail.text, controllerPassword.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AuthSessionCubit, AuthSessionState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          EasyLoading.show();
        }
        if (state is LoginLoaded) {
          EasyLoading.dismiss();
          var json = state.json;
          var statusCode = state.statusCode;
          if (statusCode == 200) {
            Navigator.pushNamedAndRemoveUntil(context, HOME, (route) => false);
          } else if (statusCode == 400) {
            MyDialog.dialogFailed(context, json['message'].toString());
          } else {
            MyDialog.dialogFailed(context, json['source'].toString());
          }
        }
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 3.8),
                Image.asset('assets/img/icon.png', height: 150),
                const SizedBox(height: 12),
                const Text("Monitoring MIS", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      children: [
                        CustomForm2(
                          textinputtype: TextInputType.emailAddress,
                          obsecureText: false,
                          controller: controllerEmail,
                          hint: 'Masukan Email',
                          prefixIcon: Icon(Icons.mail),
                          msgError: "Kolom harus di isi",
                        ),
                        const SizedBox(height: 6),
                        CustomForm2(
                          obsecureText: hidePassword,
                          controller: controllerPassword,
                          hint: 'Masukan Password',
                          prefixIcon: Icon(Icons.key),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              icon: hidePassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility)),
                          msgError: "Kolom harus di isi",
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 45,
                    child: CustomButton(
                      onTap: login,
                      text: "LOGIN",
                      color: Colors.blue[600],
                    ),
                  ),
                )
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyCopyright(),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
