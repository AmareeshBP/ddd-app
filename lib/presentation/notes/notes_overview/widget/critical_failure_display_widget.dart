import 'package:flutter/material.dart';

import 'package:ddd_app/domain/notes/note_failure.dart';

class CriticalFailureDisplay extends StatelessWidget {
  final NoteFailure noteFailure;

  const CriticalFailureDisplay({
    Key key,
    @required this.noteFailure,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            '😱',
            style: TextStyle(
              fontSize: 100,
            ),
          ),
          Text(
            noteFailure.maybeMap(
              insufficientPermission: (_) => 'Insufficient permissions',
              orElse: () => 'Unexpected error.\nPlease contact support.',
            ),
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          FlatButton(
              onPressed: () {
                print('Sending email!');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(Icons.mail),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text('I NEED HELP')
                ],
              ))
        ],
      ),
    );
  }
}
