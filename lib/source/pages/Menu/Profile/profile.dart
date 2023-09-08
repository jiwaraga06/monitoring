import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monitoring/source/services/Auth/cubit/profile_cubit.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProfileLoaded == false) {
            return Container();
          }
          var data = (state as ProfileLoaded).json;
          if (data == {}) {
            return const Center(
              child: Text('Data Kosong'),
            );
          }
          return ListView(
            children: [
              Container(
                margin: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0), boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 1.3,
                    spreadRadius: 1.3,
                    offset: Offset(1, 2),
                  )
                ]),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(FontAwesomeIcons.user),
                      title: Text('Nama'),
                      subtitle: Text(data['nama']),
                    ),
                    ListTile(
                      leading: Icon(Icons.mail_outline),
                      title: Text('Email'),
                      subtitle: Text(data['email']),
                    ),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.building),
                      title: Text('Departmen'),
                      subtitle: Text(data['departemen']),
                    ),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.building),
                      title: Text('Direktorat'),
                      subtitle: Text(data['direktorat']),
                    ),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.building),
                      title: Text('Divisi / Bagian'),
                      subtitle: Text(data['bagian']),
                    ),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.building),
                      title: Text('Seksi'),
                      subtitle: Text(data['seksi']),
                    ),
                    ListTile(
                      leading: Icon(Icons.accessibility),
                      title: Text('Posisi'),
                      subtitle: Text(data['emp_position']),
                    ),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.idCard),
                      title: Text('Level'),
                      subtitle: Text(data['level']),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
