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
  bool isShared = false;
  PieSocketEvent newMessage = PieSocketEvent("new_message");
  String websocketUrl =
      "wss://s14802.nyc1.piesocket.com/v3/1?api_key=LVB4q71feWGqIewkFA8zljrxzt5wmlbMedwM9OCf&notify_self=0&jwt:${SharedPrefUtils.getString(SharedPrefKeys.token)}";
  final List<NoteModel> _notes = [];

  List<NoteModel> get notes => _notes;

  Future<void> addNote(NoteModel note) async {
    await _offlineDatabaseService.insertNote(note);
    _notes.add(note);
    puplishMessage(note);
    notifyListeners();
  }

  clearControllers() {
    titleController.clear();
    contentController.clear();
    isShared = false;
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

    // options.setJwt(SharedPrefUtils.getString(SharedPrefKeys.token) ?? "");
    PieSocket piesocket = PieSocket(options);
    channel = piesocket.join("chat-room");
    await channel?.connect();
    channel?.listen("system:connected", (PieSocketEvent event) {
      log("HERER");
    });

    channel?.listen("new_message", (PieSocketEvent event) {
      log("New message received: ${event.getData()}");
      if (event.getData().isEmpty) return;
      NoteModel note = NoteModel.fromJson(jsonDecode(event.getData()));
      if (!_notes.any((n) => n.id == note.id)) {
        _notes.add(note);
        notifyListeners();
      } else {
        int index = _notes.indexWhere((n) => n.id == note.id);
        if (index != -1) {
          _notes[index] = note;
          notifyListeners();
        }
      }
    });
  }

  puplishMessage(NoteModel note) async {
    if (note.share == 1) {
      newMessage.setData(jsonEncode(note.toMap()));
      channel?.publish(newMessage);
    }

    //Publish event
  }

  sortByDate() {
    _notes.sort((a, b) => b.id ?? 0.compareTo(a.id ?? 0));
  }

  Future<void> updateNote(NoteModel note) async {
    await _offlineDatabaseService.updateNote(note);
    int index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = note;
      puplishMessage(note);
      notifyListeners();
    }
  }
}
