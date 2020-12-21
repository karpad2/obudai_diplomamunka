import 'package:escape_room/models/Command.dart';
import 'package:flutter/material.dart';

class Programs {
  int Program_id;
  String Program_name;
  List<Command> Commands;
  Programs(this.Program_id, this.Program_name, this.Commands);
  Programs.map(dynamic obj) {
    this.Program_id = obj["Program_id"];
    this.Program_name = obj["Program_name"];
    this.Commands = obj["Commands"];
  }
}
