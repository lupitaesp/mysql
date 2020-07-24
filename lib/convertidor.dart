import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';



class Convertir{
  //Concertir la imagen
  static Image imageFromBase64sString(String base64String){
    return Image.memory(base64Decode(base64String),
        fit: BoxFit.fill
    );

  }

  static Uint8List datafromBase64String(String base64String){
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data){
    return base64Encode(data);
  }
}