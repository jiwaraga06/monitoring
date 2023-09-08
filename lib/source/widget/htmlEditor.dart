import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class CustomHtmlEditor extends StatelessWidget {
  final HtmlEditorController? controller;
  // final QuillController? controller ;
  const CustomHtmlEditor({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    // return QuillToolbar.basic(controller: controller!);
    
    return HtmlEditor(
      controller: controller!,
      htmlEditorOptions: HtmlEditorOptions(
        hint: 'Ketik disini ....',
        shouldEnsureVisible: true,
      ),
      htmlToolbarOptions: HtmlToolbarOptions(
        toolbarPosition: ToolbarPosition.aboveEditor,
        toolbarType: ToolbarType.nativeGrid,
      ),
      otherOptions: OtherOptions(height: 550),
    );
  }
}
