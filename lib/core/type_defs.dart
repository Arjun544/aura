import 'package:fpdart/fpdart.dart';

typedef FutureEither<T> = Future<Either<Failure<String>, T>>;
typedef FutureVoid = FutureEither<void>;
typedef StatsData = List<double>;


