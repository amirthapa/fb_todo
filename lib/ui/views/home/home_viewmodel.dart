import 'package:flutter/material.dart' show TextEditingController;
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo/app/app.locator.dart';
import 'package:todo/services/databasenote_service.dart';
import 'package:todo/ui/views/home/models/note_model.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _offlineDatabaseService = locator<DatabasenoteService>();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  bool isShared = false;
  final List<NoteModel> _notes = [];

  List<NoteModel> get notes => _notes;

  Future<void> addNote(NoteModel note) async {
    await _offlineDatabaseService.insertNote(note);
    _notes.add(note);

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
    _notes.addAll(await _offlineDatabaseService.getAllNotes());
    notifyListeners();
  }

  Future<void> updateNote(NoteModel note) async {
    await _offlineDatabaseService.updateNote(note);
    int index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = note;
      notifyListeners();
    }
  }
  // changeIsShared() {
  //   isShared = !isShared;
  //   rebuildUi();
  // }

  // void showBottomSheet() {
  //   _bottomSheetService.showCustomSheet(
  //     variant: BottomSheetType.notice,
  //     title: ksHomeBottomSheetTitle,
  //     description: ksHomeBottomSheetDescription,
  //   );
  // }

  // void showDialog() {
  //   _dialogService.showCustomDialog(
  //     variant: DialogType.infoAlert,
  //     title: 'Stacked Rocks!',
  //     description: 'Give stacked $_counter stars on Github',
  //   );
  // }
}
