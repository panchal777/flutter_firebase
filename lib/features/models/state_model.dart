class StateModel {
  bool isLoading;
  bool isError;
  bool isSuccess;
  bool showProgress;
  String msg;

  StateModel({
    this.isError = false,
    this.isLoading = false,
    this.showProgress = false,
    this.isSuccess = false,
    this.msg = '',
  });
}
