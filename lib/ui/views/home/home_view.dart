import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:todo/ui/common/common.dart';
import 'package:todo/ui/views/home/models/note_model.dart';
import 'package:todo/ui/views/home/widgets/note_item_widget.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kcPrimaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          _addNote(context: context, viewModel: viewModel);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: kcPrimaryColor,
        foregroundColor: Colors.white,
        title: Text(
            'Welcome ${SharedPrefUtils.getString(SharedPrefKeys.userName) ?? 'User'}'),
      ),
      body: SafeArea(
        child: viewModel.busy(viewModel.notes)
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: viewModel.notes.isEmpty
                    ? const Center(child: Text('No notes found'))
                    : SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            itemBuilder: (context, index) {
                              final note = viewModel.notes[index];
                              return NoteItemWidget(
                                noteModel: note,
                                onTap: () {
                                  _addNote(
                                      context: context,
                                      viewModel: viewModel,
                                      noteModel: note);
                                },
                              );
                            },
                            itemCount: viewModel.notes.length),
                      )),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) =>
      HomeViewModel()..fetchNotes();

  _addNote(
      {required BuildContext context,
      required HomeViewModel viewModel,
      NoteModel? noteModel}) async {
    viewModel.contentController.text = noteModel?.content ?? '';
    viewModel.titleController.text = noteModel?.title ?? '';
    bool isShared = noteModel?.share == 1 ? true : false;
    return showModalBottomSheet(
      showDragHandle: true,
      elevation: 3,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: noteModel != null ? true : false,
                        child: IconButton(
                            onPressed: () async {
                              if (noteModel != null) {
                                viewModel.deleteNote(noteModel.id ?? 0);
                                viewModel.clearControllers();
                                Navigator.pop(context);
                              }
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      )
                    ],
                  ),
                  TextField(
                    controller: viewModel.titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  verticalSpaceMedium,
                  TextField(
                    controller: viewModel.contentController,
                    decoration: const InputDecoration(labelText: 'Content'),
                  ),
                  verticalSpaceMedium,
                  Row(
                    children: [
                      const Text("Share with others?"),
                      verticalSpaceSmall,
                      Checkbox(
                          value: isShared,
                          onChanged: (value) {
                            setState(() {
                              isShared = !isShared;
                            });
                          }),
                    ],
                  ),
                  verticalSpaceMedium,
                  AppButton(
                    onPressed: () {
                      if (viewModel.titleController.text.isEmpty ||
                          viewModel.contentController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "All fields are required");
                        return;
                      }
                      noteModel == null
                          ? viewModel.addNote(NoteModel(
                              id: DateTime.now().microsecondsSinceEpoch,
                              title: viewModel.titleController.text,
                              content: viewModel.contentController.text,
                              timestamp:
                                  '${DateTime.now().day}/${DateTime.now().month}',
                              share: isShared == true ? 1 : 0))
                          : viewModel.updateNote(NoteModel(
                              id: noteModel.id ??
                                  DateTime.now().microsecondsSinceEpoch,
                              title: viewModel.titleController.text,
                              content: viewModel.contentController.text,
                              timestamp:
                                  '${DateTime.now().day}/${DateTime.now().month}',
                              share: isShared == true ? 1 : 0,
                            ));

                      viewModel.clearControllers();

                      Navigator.pop(context);
                    },
                    label: noteModel == null ? "Add Note" : "Edit Note",
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
