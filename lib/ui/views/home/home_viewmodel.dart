import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart' show TextEditingController;
import 'package:piesocket_channels/channels.dart';
import 'package:stacked/stacked.dart';
import 'package:todo/app/app.locator.dart';
import 'package:todo/services/databasenote_service.dart';
import 'package:todo/ui/common/shared_pref_keys.dart';
import 'package:todo/ui/common/shared_pref_utils.dart';
import 'package:todo/ui/views/home/models/note_model.dart';

class HomeViewModel extends BaseViewModel {
  final _offlineDatabaseService = locator<DatabasenoteService>();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  Channel? channel;

  PieSocketEvent newMessage = PieSocketEvent("new_message");

  final List<NoteModel> _notes = [];

  List<NoteModel> get notes => _notes;

  Future<void> addNote(NoteModel note) async {
    await _offlineDatabaseService.insertNote(note);
    _notes.add(note);
    rebuildUi();
    puplishMessage(note);
  }

  clearControllers() {
    titleController.clear();
    contentController.clear();
  }

  Future<void> deleteNote(int id) async {
    await _offlineDatabaseService.deleteNote(id);
    _notes.removeWhere((note) => note.id == id);

    notifyListeners();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  disposeControllers() {
    titleController.dispose();
    contentController.dispose();
  }

  Future<void> fetchNotes() async {
    _notes.clear();
    await initSocket();

    _notes.addAll(await _offlineDatabaseService.getAllNotes());
    notifyListeners();
  }

  initSocket() async {
    PieSocketOptions options = PieSocketOptions();
    options.setClusterId("s14802.nyc1");
    options.setNotifySelf(false);
    options.setApiKey("LVB4q71feWGqIewkFA8zljrxzt5wmlbMedwM9OCf");

    options.setJwt(SharedPrefUtils.getString(SharedPrefKeys.token) ?? "");
    PieSocket piesocket = PieSocket(options);
    channel = piesocket.join("chat-room");
    await channel?.connect();
    channel?.listen("system:connected", (PieSocketEvent event) {});

    channel?.listen("new_message", (PieSocketEvent event) {
      log(event.toString());
      if (event.getData().isEmpty) return;
      NoteModel note = NoteModel.fromJson(jsonDecode(event.getData()));

      if (!_notes.any((n) => n.id == note.id)) {
        _notes.add(note);
        notifyListeners();
      } else {
        int index = _notes.indexWhere((n) => n.id == note.id);
        if (index != -1) {
          _notes[index] = note;
          rebuildUi();
        }
      }
    });
  }

  puplishMessage(NoteModel note) async {
    if (note.share == 1) {
      newMessage.setData(jsonEncode(note.toMap()));
      channel?.publish(newMessage);
    }
  }

  sortByDate() {
    _notes.sort((a, b) => b.id ?? 0.compareTo(a.id ?? 0));
  }

  Future<void> updateNote(NoteModel note) async {
    await _offlineDatabaseService.updateNote(note);
    int index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = note;

      rebuildUi();
      puplishMessage(note);
    }
  }
}
