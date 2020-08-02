import 'package:ddd_app/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:ddd_app/presentation/notes/notes_overview/widget/critical_failure_display_widget.dart';
import 'package:ddd_app/presentation/notes/notes_overview/widget/error_note_card_widget.dart';
import 'package:ddd_app/presentation/notes/notes_overview/widget/note_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesOverviewBodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteWatcherBloc, NoteWatcherState>(
      builder: (context, state) {
        return state.map(
          initial: (_) => Container(),
          loadInProgress: (_) =>
              const Center(child: CircularProgressIndicator()),
          loadSuccess: (state) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final note = state.notes[index];
                if (note.failureOption.isSome()) {
                  return ErrorNoteCard(note: note);
                } else {
                  return NoteCard(note: note);
                }
              },
              itemCount: state.notes.size,
            );
          },
          loadFailure: (state) => CriticalFailureDisplay(
            noteFailure: state.noteFailure,
          ),
        );
      },
    );
  }
}
