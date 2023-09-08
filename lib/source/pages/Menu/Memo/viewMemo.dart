import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll/infinite_scroll_list.dart';
import 'package:intl/intl.dart';
import 'package:monitoring/source/pages/Menu/Memo/memoPdf.dart';
import 'package:monitoring/source/router/string.dart';
import 'package:monitoring/source/services/Memo/cubit/memo_cubit.dart';
import 'package:monitoring/source/services/Memo/cubit/pdf_cubit.dart';

class ViewMemo extends StatefulWidget {
  const ViewMemo({super.key});

  @override
  State<ViewMemo> createState() => _ViewMemoState();
}

class _ViewMemoState extends State<ViewMemo> {
  var angka = 10;
  ScrollController controller = ScrollController();

  void showModal(data) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(title: Text(data['perihal'])),
            const SizedBox(height: 6),
            const Divider(thickness: 2),
            const SizedBox(height: 6),
            ListTile(
              onTap: () {
                Get.toNamed(EDIT_MEMO, arguments: {
                  'memo_id': data['memo_id'],
                  'no_surat': data['no_surat'],
                  'perihal': data['perihal'],
                  'kepada': data['kepada'],
                  'isi': data['isi'],
                  'penutup': data['penutup'],
                  'email': data['email'],
                });
              },
              leading: Icon(Icons.edit),
              title: Text('Edit'),
            ),
            ListTile(
              onTap: () {
                // BlocProvider.of<MemoCubit>(context).showPDF(data['memo_id']);
                BlocProvider.of<PdfCubit>(context).createFileOfPdfUrl(data['memo_id'], context);
                // Navigator.pop(context);
              },
              leading: Icon(Icons.visibility),
              title: Text('Show PDF'),
            ),
            ListTile(
              onTap: () {
                BlocProvider.of<PdfCubit>(context).sharePdf(data['memo_id'], context);
              },
              leading: Icon(Icons.share),
              title: Text('Share PDF'),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(Icons.close),
              title: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MemoCubit>(context).getMemo(angka);
    controller = ScrollController();
    controller.addListener(() {
      // convert();
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print('mentok');
        var a = angka++;
        print(a);
        BlocProvider.of<MemoCubit>(context).getMemo(angka++);
      }
    });
    print(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Memo'),
      ),
      body: BlocBuilder<MemoCubit, MemoState>(
        builder: (context, state) {
          if (state is MemoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MemoLoaded == false) {
            return const Center();
          }
          var json = (state as MemoLoaded).json;
          if (json.isEmpty) {
            return const Center(
              child: Text('Data Kosong'),
            );
          }
          // return InfiniteScrollList(
          //   onLoadingStart: (page) async {
          //     print('Page: $page');
          //     // BlocProvider.of<MemoCubit>(context).getMemo();
          //   },
          //   everythingLoaded: false,
          //   addAutomaticKeepAlives: false,
          //   children: b.map<Widget>((data) {
          //     // var date = DateFormat('MMM d,yyyy').format(DateTime.parse(data['created_at'].toString().split(' ')[0]));
          //     return Container(
          //       child: ListTile(
          //         leading: Icon(FontAwesomeIcons.bookOpen),
          //         trailing: IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.ellipsis)),
          //         title: Text(data.toString(), style: TextStyle(fontSize: 17)),
          //         // subtitle: Column(
          //         //   crossAxisAlignment: CrossAxisAlignment.start,
          //         //   children: [
          //         //     const SizedBox(height: 6),
          //         //     Text(data['no_surat']),
          //         //     Text(date),
          //         //   ],
          //         // ),
          //       ),
          //     );
          //   }).toList(),
          // );
          return Container(
            margin: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0), boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1.3,
                spreadRadius: 1.3,
                offset: Offset(1, 2),
              ),
            ]),
            child: ListView.builder(
              controller: controller,
              itemCount: json.length,
              itemBuilder: (context, index) {
                var data = json[index];
                var date = DateFormat('MMM d,yyyy').format(DateTime.parse(data['created_at'].toString().split(' ')[0]));
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(FontAwesomeIcons.bookOpen),
                      trailing: IconButton(
                          onPressed: () {
                            showModal(data);
                          },
                          icon: Icon(FontAwesomeIcons.ellipsis)),
                      title: Text(data['perihal'], style: TextStyle(fontSize: 17)),
                      // title: Text(data.toString(), style: TextStyle(fontSize: 17)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          Text(data['no_surat']),
                          Text(date),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Divider(color: Colors.grey[800])
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
