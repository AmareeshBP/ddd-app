import 'package:ddd_app/application/notes/note_watcher/note_watcher_bloc.dart';
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
                  return Container(
                    color: Colors.red,
                    height: 100,
                    width: 100,
                  );
                } else {
                  return Container(
                    color: Colors.green,
                    height: 100,
                    width: 100,
                  );
                }
              },
              itemCount: state.notes.size,
            );
          },
          loadFailure: (_) => Container(
            color: Colors.yellow,
            height: 200,
            width: 200,
          ),
        );
      },
    );
  }
}
