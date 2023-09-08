import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monitoring/source/router/string.dart';
import 'package:monitoring/source/services/Auth/cubit/auth_session_cubit.dart';
import 'package:monitoring/source/widget/copyright.dart';
import 'package:monitoring/source/widget/customButton.dart';
import 'package:monitoring/source/widget/drawer.dart';

class Memo extends StatefulWidget {
  const Memo({super.key});

  @override
  State<Memo> createState() => _MemoState();
}

class _MemoState extends State<Memo> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthSessionCubit>(context).getRole();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, HOME, (route) => false);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 2.0,
            title: Text('MIS | Memo'),
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 45,
                        child: CustomButton(
                          onTap: () {
                            Navigator.pushNamed(context, VIEW_MEMO);
                          },
                          text: 'View Memo',
                          color: Colors.green[600],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 45,
                        child: CustomButton(
                          onTap: () {
                            Navigator.pushNamed(context, ADD_MEMO);
                          },
                          text: 'Add New Memo',
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
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
    );
  }
}
