import 'dart:async';

class SignInBloc {
  final StreamController<bool> _isLoadingController = StreamController<bool>();

  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  void dispose() {
    _isLoadingController.close();
  }
}
