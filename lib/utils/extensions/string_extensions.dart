extension Validation on String {
  bool get isNullOrEmpty => (this != null && this.isNotEmpty) ? false : true;
}
