import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visual_notes_app/layout/visualNotesHome/cubit/login_cubit_states.dart';
import 'package:visual_notes_app/models/visualNotesData/data.dart';
import 'package:visual_notes_app/shared/components/components.dart';
class AppCubit extends Cubit<AppCubitStates> {
  AppCubit() : super(AppCubitInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  String status = '';
  List<String> selectStatus = ['opened', 'closed'];
  List<Data> data = [];

  void restNoteData()
  {
    titleController.text='';
    descriptionController.text='';
    status='';
  }
  void selectNoteState(val)
  {
    status = val;
    emit(AppCubitSelectNoteState());
  }

  XFile selectedFile;
  File imageFile;
  String imageUrl;

  void PickImage(context) async
  {
          selectedFile =await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 20);
          if(selectedFile!=null) {
      imageFile = File(selectedFile.path);
      UploadImage(imageFile,context);
    } else
            showToast('something went wrong', Colors.red, context);
  }

  void UploadImage(imageFile,context){
    FirebaseStorage.instance
        .ref()
        .putFile(imageFile)
        .then((val) {
           val.ref.getDownloadURL().then((value){
             imageUrl=value;
             emit(AppCubitUploadImageSuccessState());
           }).catchError((onError){
             showToast('something went wrong', Colors.red, context);
           });
    });
  }

   void addNote(String collectionName,String docName,Map<String,dynamic>data,context)
  {
    FirebaseFirestore.instance
        .collection(collectionName)
        .doc(docName)
        .set(data)
        .whenComplete(() {
      showToast('done', Colors.blue, context);
      restNoteData();
      emit(AppCubitAddNoteSuccessState());
    });
  }

  void getNotes(String collectionName)
  {
    FirebaseFirestore.instance
        .collection(collectionName)
        .snapshots()
        .listen((event) {
          data=[];
          event.docs.forEach((element) {
            data.add(Data.fromJson(element.data()));
          });

          if(data.length==event.docs.length) {
        emit(AppCubitGetNotesSuccessState());
      }
    });
  }
}
