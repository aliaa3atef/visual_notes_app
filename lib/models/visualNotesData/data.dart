import 'package:flutter/material.dart';

class Data{
  String title , image, description , date ,status;

  Data({
    @required this.title,
    @required this.image,
    @required this.description,
    @required this.date,
    @required this.status
});

  Data.fromJson(Map<String,dynamic>json){
    image=json['image'];
    title=json['title'];
    description=json['description'];
    date=json['date'];
    status=json['status'];
  }

  Map<String,dynamic> toMap()
  {
    Map<String,dynamic> map={};
    map['image']=image;
    map['status']=status;
    map['date']=date;
    map['description']=description;
    map['title']=title;

    return map;
  }
}