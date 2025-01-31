import 'package:flutter/material.dart';
import 'package:tahfeez_app/dto/register/register_models.dart';
import 'package:tahfeez_app/register/register_controller.dart';
import 'package:tahfeez_app/dto/login/teacher/teacher_models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> showTeacherSelectionDialog(
    BuildContext parentContext,
    RegisterController registerController,
    RegisterRequest registerRequest) async {
  return showDialog<void>(
    context: parentContext,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.selectTeacher),
        content: SizedBox(
          width: double.maxFinite,
          child: FutureBuilder<List<TeacherSelectionResponse>>(
            future: registerController.fetchTeachersList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text(AppLocalizations.of(context)!.noTeachersAvailable);
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final teacher = snapshot.data![index];
                  return ListTile(
                    title: Text(teacher.name),
                    subtitle: Text(teacher.phone),
                    onTap: () {
                      Navigator.pop(context);
                      registerController.register(
                        parentContext,
                        name: registerRequest.name,
                        phone: registerRequest.phone,
                        password: registerRequest.password,
                        level: registerRequest.level,
                        gender: registerRequest.gender,
                        birthDate: registerRequest.birthDate,
                        teacherId: teacher.id,
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      );
    },
  );
}
