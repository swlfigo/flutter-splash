class DataResult {
  Object? data;
  bool result;
  Function? next;
  Object? error;
  DataResult(this.data, this.result, this.error, {this.next});
}
