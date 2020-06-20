import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_app/domain/auth/i_auth_facade.dart';
import 'package:ddd_app/domain/core/errors.dart';
import 'package:ddd_app/injection.dart';

extension FirestoreX on Firestore {
  Future<DocumentReference> userDocument() async {
    final userOpton = await getIt<IAuthFacade>().getSignedInUser();
    final user = userOpton.getOrElse(() => throw NotAuthenticatedError());
    return Firestore.instance.collection('user').document(user.id.getOrCrash());
  }
}

extension DocumentReferenceX on DocumentReference {
  CollectionReference get noteCollection => collection('notes');
}
