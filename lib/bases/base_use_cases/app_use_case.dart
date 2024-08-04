abstract class AppUseCase<T, R> {
  const AppUseCase();
  Future<T> invoke(R param);
}
