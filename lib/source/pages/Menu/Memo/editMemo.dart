import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:monitoring/source/services/Memo/cubit/memo_cubit.dart';
import 'package:monitoring/source/widget/customButton.dart';
import 'package:monitoring/source/widget/customDialog.dart';
import 'package:monitoring/source/widget/customFormField.dart';
import 'package:monitoring/source/widget/htmlEditor.dart';

class EditMemo extends StatefulWidget {
  const EditMemo({super.key});

  @override
  State<EditMemo> createState() => _EditMemoState();
}

class _EditMemoState extends State<EditMemo> {
  var arguments;
  var memoid;
  TextEditingController controllerNoSurat = TextEditingController();
  TextEditingController controllerPerihal = TextEditingController();
  TextEditingController controllerKepada = TextEditingController();
  final HtmlEditorController controller = HtmlEditorController();
  final formkey = GlobalKey<FormState>();

  void update() async {
    var txt = await controller.getText();
    if (formkey.currentState!.validate()) {
      BlocProvider.of<MemoCubit>(context).updateMemo(
        memoid,
        controllerNoSurat.text,
        controllerPerihal.text,
        controllerKepada.text,
        txt,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      arguments = Get.arguments;
      memoid = arguments['memo_id'];
      controllerNoSurat = TextEditingController(text: arguments['no_surat']);
      controllerPerihal = TextEditingController(text: arguments['perihal']);
      controllerKepada = TextEditingController(text: arguments['kepada']);
      print(arguments['isi']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Memo'),
        actions: [
          IconButton(
              onPressed: () {
                controller.setText(arguments['isi']);
              },
              icon: Icon(Icons.refresh)),
        ],
      ),
      body: BlocListener<MemoCubit, MemoState>(
        listener: (context, state) {
          if (state is UpdateMemoLoading) {
            EasyLoading.show();
          }
          if (state is UpdateMemoLoaded) {
            EasyLoading.dismiss();
            var statusCode = state.statusCode;
            var json = state.json;
            if (statusCode == 200) {
              MyDialog.dialogSuccess(context, json['message']);
              BlocProvider.of<MemoCubit>(context).getMemo(10);
            } else {
              MyDialog.dialogFailed(context, json['message']);
            }
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2),
                          child: CustomForm(
                            controller: controllerNoSurat,
                            label: 'No Surat',
                            hint: 'Masukan No Surat',
                            msgError: 'Kolom harus di isi',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2),
                          child: CustomForm(
                            controller: controllerPerihal,
                            label: 'Perihal',
                            hint: 'Masukan Perihal',
                            msgError: 'Kolom harus di isi',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2),
                          child: CustomForm(
                            controller: controllerKepada,
                            label: 'Kepada',
                            hint: 'Masukan Kepada',
                            msgError: 'Kolom harus di isi',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: CustomHtmlEditor(controller: controller)),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      onTap: update,
                      color: Colors.green[600],
                      text: 'UPDATE',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
