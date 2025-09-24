class StringCalculator {
  int add(String numbers) {
    if (numbers.trim().isEmpty) return 0;
    final parts = numbers
        .split(RegExp('[,\\n]'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    if (parts.isEmpty) return 0;

    int sum = 0;
    for (final p in parts) {
      sum += int.parse(p);
    }
    return sum;
  }
}
