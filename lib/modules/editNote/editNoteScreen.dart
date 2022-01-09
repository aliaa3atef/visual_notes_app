import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:visual_notes_app/layout/visualNotesHome/cubit/app_cubit.dart';
import 'package:visual_notes_app/layout/visualNotesHome/cubit/login_cubit_states.dart';
import 'package:visual_notes_app/models/visualNotesData/data.dart';
import 'package:visual_notes_app/shared/components/components.dart';
import 'package:visual_notes_app/shared/styles/colors.dart';

class EditNoteScreen extends StatelessWidget {

  final Data data;

  EditNoteScreen(this.data);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppCubitStates>(
      listener: (context, state) {
        if(state is AppCubitUpdateNoteSuccessState) {
          showToast('Data Updated Successfully', colorApp, context);
        }

      },
      builder: (context, state) {
        cubit.titleController.text = data.title;
        cubit.descriptionController.text = data.description;
        cubit.status = data.status;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: "Edit Visual Note",
          ),
          body: Container(
            height: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Visual Note Image : ' , style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.black
                      ),),

                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.camera_alt_rounded),
                        color: colorApp,
                        onPressed: () {
                          cubit.PickImage(context);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Image(image: NetworkImage(data.image) , fit: BoxFit.cover,),
                    ),

                  Divider(
                    color: colorApp,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  sharedTextFormField(
                    controller: cubit.titleController,
                    text: 'Enter Title',
                    type: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  sharedTextFormField(
                      controller: cubit.descriptionController,
                      text: 'Enter Description',
                      type: TextInputType.text),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButton(
                    value: cubit.status.isNotEmpty ? cubit.status : null,
                    isExpanded: true,
                    hint: const Text("Select Status"),
                    items: cubit.selectStatus.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (val) {
                      cubit.selectNoteState(val);
                    },
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  Container(
                    width: double.infinity,
                    color: colorApp,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide.none
                        ),
                        onPressed: () {
                            cubit.updateNote(
                              'notes',
                              cubit.titleController.text,
                              Data(
                                title: cubit.titleController.text,
                                image: cubit.imageUrl,
                                description: cubit.descriptionController.text,
                                date: DateFormat('dd/MM/yyyy HH:mm a')
                                    .format(DateTime.now()),
                                status: cubit.status,
                              ).toMap(),
                              context,
                            );
                            Navigator.pop(context);
                        },
                        child: const Text("Update" , style: TextStyle(color: Colors.white , fontSize: 20),)),
                  ),
                ],
              ),
            ),
          ),

        );
      },
    );
  }
}
