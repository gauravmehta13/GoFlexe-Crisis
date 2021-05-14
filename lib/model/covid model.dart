import 'package:flutter/material.dart';

class MythBusterModel {
  final String myth;
  final String fact;

  MythBusterModel({
    @required this.myth,
    @required this.fact,
  });
}

class SymptomsModel {
  final String title;
  final String description;
  final String imageURL;

  SymptomsModel({
    @required this.title,
    @required this.description,
    @required this.imageURL,
  });
}

class FAQModel {
  final String title;
  final String description;

  FAQModel({
    @required this.title,
    @required this.description,
  });
}
