class StringCalculator {
  int add(String numbers) {
    if (numbers.trim().isEmpty) return 0;
    final parts = numbers
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    if (parts.isEmpty) return 0;
    if (parts.length > 2) {
      throw const FormatException('Only up to two numbers are allowed');
    }
    int sum = 0;
    for (final p in parts) {
      sum += int.parse(p);
    }
    return sum;
  }
}
