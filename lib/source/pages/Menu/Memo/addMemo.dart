import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_quill/flutter_quill.dart';
import 'package:html_editor_enhanced/html_editor.dart';
// import 'package:html_editor_enhanced/html_editor.dart';
import 'package:monitoring/source/services/Memo/cubit/memo_cubit.dart';
import 'package:monitoring/source/widget/customButton.dart';
import 'package:monitoring/source/widget/customDialog.dart';
import 'package:monitoring/source/widget/customFormField.dart';
import 'package:monitoring/source/widget/htmlEditor.dart';
// import 'package:monitoring/source/widget/htmlEditor.dart';

class AddMemo extends StatefulWidget {
  const AddMemo({super.key});

  @override
  State<AddMemo> createState() => _AddMemoState();
}

class _AddMemoState extends State<AddMemo> {
  TextEditingController controllerNoSurat = TextEditingController();
  TextEditingController controllerPerihal = TextEditingController();
  TextEditingController controllerKepada = TextEditingController();
  HtmlEditorController controller = HtmlEditorController();
  final formkey = GlobalKey<FormState>();
  // QuillController controllers = QuillController.basic();
  // QuillController controller = QuillController.basic();
  // QuillController _controller = QuillController(document: Document.fromJson(jsonDecode('source')), selection: TextSelection.collapsed(offset: 0));
  void save() async {
    // print(_controller);
    var txt = await controller.getText();
    if (formkey.currentState!.validate()) {
      BlocProvider.of<MemoCubit>(context).addMemo(
        controllerNoSurat.text,
        controllerPerihal.text,
        controllerKepada.text,
        txt,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Memo'),
      ),
      body: BlocListener<MemoCubit, MemoState>(
        listener: (context, state) {
          if (state is AddMemoLoading) {
            EasyLoading.show();
          }
          if (state is AddMemoLoaded) {
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
                    child: CustomHtmlEditor(controller: controller),
                    // child: Column(
                    //   children: [
                    // QuillToolbar.basic(controller: controllers),
                    //     QuillEditor(
                    //       controller: _controller,
                    //       focusNode: FocusNode(),
                    //       scrollController: ScrollController(),
                    //       scrollable: true,
                    //       padding: const EdgeInsets.all(8.0),
                    //       autoFocus: false,
                    //       readOnly: false,
                    //       expands: false,
                    //       maxHeight: 500,
                    //     ),
                    //   ],
                    // )
                  ),
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
                      onTap: () {
                        save();
                      },
                      color: Colors.green[600],
                      text: 'SAVE',
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
