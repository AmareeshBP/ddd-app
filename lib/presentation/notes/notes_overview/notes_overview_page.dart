import 'package:auto_route/auto_route.dart';
import 'package:ddd_app/presentation/notes/notes_overview/widget/notes_overview_body_widget.dart';
import 'package:ddd_app/presentation/notes/notes_overview/widget/uncompleted_switch.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth/auth_bloc.dart';
import '../../../application/notes/note_actor/note_actor_bloc.dart';
import '../../../application/notes/note_watcher/note_watcher_bloc.dart';
import '../../../injection.dart';
import '../../routes/router.gr.dart';

class NotesOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteWatcherBloc>(
          create: (context) => getIt<NoteWatcherBloc>()
            ..add(const NoteWatcherEvent.watchAllStarted()),
        ),
        BlocProvider<NoteActorBloc>(
          create: (context) => getIt<NoteActorBloc>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) => state.maybeMap(
              unauthenticated: (_) =>
                  ExtendedNavigator.of(context).replace(Routes.signInPage),
              orElse: () => null,
            ),
          ),
          BlocListener<NoteActorBloc, NoteActorState>(
            listener: (context, state) => state.maybeMap(
              deleteFailure: (state) {
                FlushbarHelper.createError(
                  duration: const Duration(seconds: 5),
                  message: state.noteFailure.map(
                    unexpected: (_) =>
                        'Unexpected error occurd while deleting, please contact support.',
                    insufficientPermission: (_) => 'Insufficient Permission ❌',
                    unableToUpdate: (_) => 'Impossoble error',
                  ),
                );
                return;
              },
              orElse: () => null,
            ),
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
            leading: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                context.bloc<AuthBloc>().add(const AuthEvent.signedOut());
              },
            ),
            actions: <Widget>[
              UnCompletedSwitch(),
            ],
          ),
          body: NotesOverviewBodyWidget(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              ExtendedNavigator.of(context).pushNoteFormPage();
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
