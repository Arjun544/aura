class RangeSize {
  final int from;
  final int to;

  RangeSize({required this.from, required this.to});
}

RangeSize getPagination({
  required int page,
  required int limit,
}) {
  final from = page * limit;
  final to = from + limit - 1;

  return RangeSize(from: from, to: to);
}
