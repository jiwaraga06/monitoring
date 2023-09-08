import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monitoring/source/router/string.dart';
import 'package:monitoring/source/services/Auth/cubit/auth_session_cubit.dart';
import 'package:monitoring/source/services/SessionManager/cubit/kick_user_cubit.dart';
import 'package:monitoring/source/services/SessionManager/cubit/sessionmanager_cubit.dart';
import 'package:monitoring/source/widget/copyright.dart';
import 'package:monitoring/source/widget/drawer.dart';

class SessionManager extends StatefulWidget {
  const SessionManager({super.key});

  @override
  State<SessionManager> createState() => _SessionManagerState();
}

class _SessionManagerState extends State<SessionManager> {
  var defaultRowsPerPage = 10;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SessionmanagerCubit>(context).getUserActive();
    BlocProvider.of<AuthSessionCubit>(context).getRole();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, HOME, (route) => false);
        return true;
      },
      child: BlocListener<KickUserCubit, KickUserState>(
        listener: (context, state) {
          if (state is KickUserLoading) {
            EasyLoading.show();
          }
          if (state is KickUserLoaded) {
            EasyLoading.dismiss();
            var json = state.json;
            var statusCode = state.statusCode;
            EasyLoading.showSuccess(json.toString(), duration: const Duration(seconds: 1));
          }
        },
        child: Scaffold(
            appBar: AppBar(
              elevation: 2.0,
              title: Text('MIS | Session Manager'),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, PROFILE);
                    },
                    icon: Icon(Icons.more_horiz_rounded)),
              ],
            ),
            drawer: CustomDrawer(),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: BlocBuilder<SessionmanagerCubit, SessionmanagerState>(
                    builder: (context, state) {
                      if (state is SessionmanagerLoading) {
                        return const SizedBox(
                          height: 80,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (state is SessionmanagerLoaded == false) {
                        return Container();
                      }
                      var json = (state as SessionmanagerLoaded).json;
                      final DataTableSource pageTable = MyData(pageTable: json, context: context);
                      if (json.isEmpty) {
                        return const SizedBox(
                          height: 80,
                          child: Center(child: Text("Data Kosong")),
                        );
                      }
                      int _currentSortColumn = 0;
                      bool _isAscending = true;

                      int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
                      int _rowsPerPage1 = PaginatedDataTable.defaultRowsPerPage;
                      var tableItemsCount = json.length;
                      // var defaultRowsPerPage = PaginatedDataTable.defaultRowsPerPage;

                      var isRowCountLessDefaultRowsPerPage = tableItemsCount < defaultRowsPerPage;
                      _rowsPerPage = isRowCountLessDefaultRowsPerPage ? tableItemsCount : defaultRowsPerPage;
                      return PaginatedDataTable(
                        horizontalMargin: 10,
                        sortColumnIndex: _currentSortColumn,
                        sortAscending: _isAscending,
                        // rowsPerPage: isRowCountLessDefaultRowsPerPage ? _rowsPerPage : _rowsPerPage1,
                        rowsPerPage: defaultRowsPerPage,
                        // dataRowHeight: 50,
                        showCheckboxColumn: false,
                        onRowsPerPageChanged: (value) {
                          print(value);
                          setState(() {
                            defaultRowsPerPage = value!;
                          });
                        },
                        columns: [
                          DataColumn(label: Text("No")),
                          DataColumn(label: Text("Email")),
                          DataColumn(label: Text("Last Login")),
                          DataColumn(label: Text("Device ID")),
                          DataColumn(label: Text("Aksi")),
                        ],
                        source: pageTable,
                      );
                    },
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [MyCopyright()],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class MyData extends DataTableSource {
  final List? pageTable;
  final BuildContext? context;

  MyData({this.context, this.pageTable});
  // final List _data = pageTable ;
  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => pageTable!.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text('${index + 1}')),
      DataCell(Text(pageTable![index]['email'].toString())),
      DataCell(Text(pageTable![index]["last_login"])),
      DataCell(Text(pageTable![index]["uuid_mobile"].toString())),
      DataCell(IconButton(
          onPressed: () {
            print(pageTable![index]);
            BlocProvider.of<KickUserCubit>(context!).kickUser(pageTable![index]['email'].toString(), context!);
            BlocProvider.of<SessionmanagerCubit>(context!).getUserActive();
          },
          icon: Icon(Icons.delete_forever, size: 25, color: Colors.red[600]))),
    ]);
  }
}
