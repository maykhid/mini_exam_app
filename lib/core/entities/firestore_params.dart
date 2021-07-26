class FirestoreParams {
  final String collection;
  final String document;
  final data;

  FirestoreParams(
      {required this.collection, required this.document, this.data});
}
