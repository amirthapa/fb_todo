import 'package:flutter/material.dart';
import 'package:todo/ui/views/home/models/note_model.dart';

class NoteItemWidget extends StatelessWidget {
  final NoteModel? noteModel;
  final Function? onTap;
  const NoteItemWidget({super.key, this.noteModel, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            subtitle: Text(
              noteModel?.content ?? 'No Description',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            trailing: Visibility(
              visible: (noteModel?.share == 1) ? true : false,
              child: const Icon(Icons.share, color: Colors.grey),
            ),
            leading: Text(noteModel?.timestamp ?? 'No Date',
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
            title: Text(
              noteModel?.title ?? 'No Title',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
