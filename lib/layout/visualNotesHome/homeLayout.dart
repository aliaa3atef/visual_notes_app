import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_notes_app/layout/visualNotesHome/cubit/app_cubit.dart';
import 'package:visual_notes_app/layout/visualNotesHome/cubit/login_cubit_states.dart';
import 'package:visual_notes_app/models/visualNotesData/data.dart';
import 'package:visual_notes_app/shared/components/components.dart';
import 'package:visual_notes_app/shared/styles/colors.dart';

class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit,AppCubitStates>(
      listener: (context, state) {
      },
        builder: (context, state) {
          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: "Home",
              actions: [
                OutlinedButton(onPressed: () {
                  buildAlertDialog(context: context,state: state);
                },
                  child: Text(
                    "Add New Visual Note", style: TextStyle(color: colorApp,),),
                )

              ],
            ),
            body: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return buildItem(context, index);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 1,
              ),
              itemCount: cubit.data.length,
            ),
          );
        },
    ) ;
  }

  Future<void> buildAlertDialog({
    @required BuildContext context,
    state
  }) {
    var cubit = AppCubit.get(context);
    AlertDialog alert = AlertDialog(
      scrollable: true,
      content: Container(
        height: 360,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Upload Image : '),
                const Spacer(),
                Stack(
                  children: [
                    IconButton(icon: const Icon(Icons.camera_alt_rounded), color: colorApp,onPressed: () {
                      cubit.PickImage(context);
                    },
                    ),
                  ],
                ),
              ],
            ),
             const SizedBox(
              height: 10,
            ),
            Divider(color: colorApp,),
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
                 Navigator.pop(context);
                 buildAlertDialog(context: context);
              },
           ),

          const SizedBox(
              height: 10,
            ),

            OutlinedButton(
             onPressed: () {
                if(cubit.CheckDataReady())
                  {
                    cubit.addNote(
                      'notes',
                      cubit.titleController.text,
                      Data(
                        title: cubit.titleController.text,
                        image: cubit.imageUrl,
                        description: cubit.descriptionController.text,
                        date: DateTime.now().toString().split(' ').first,
                        time: TimeOfDay.now().format(context).toString(),
                        status: cubit.status,
                      ).toMap(),
                      context,
                    );
                    Navigator.pop(context);
                  }else
                    {
                      showToast('data not ready', Colors.red, context);
                    }

             },
             child: const Text("Add")
            ),
          ],
        ),
      ),
    );
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return alert;
        });
  }

  Widget buildItem(BuildContext context, index) {
    var cubit = AppCubit.get(context);
    return GestureDetector(
      onLongPress: () {
        showMenu(
          position: const RelativeRect.fromLTRB(0, 0, 0, 0),
          items: <PopupMenuEntry>[
            PopupMenuItem(
              onTap: () {
                cubit.deleteNote(cubit.data[index].title, index, context);
              },
              value: index,
              child: Row(
                children: [
                  Icon(Icons.delete, color: colorApp,),
                  const Text("Delete"),
                ],
              ),
            )
          ],
          context: context,
        );
      },
      child: Card(
        elevation: 20,
        color: colorApp,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 120,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child:
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  cubit.data[index].title,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2,
                ),
                const SizedBox(
                  width: 30,
                ),
                Image(
                  image: NetworkImage(cubit.data[index].image),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 30,
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    width: 100,
                    child: Text(
                      cubit.data[index].description,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText2,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cubit.data[index].date,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText2,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      cubit.data[index].time,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText2,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  cubit.data[index].status,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

