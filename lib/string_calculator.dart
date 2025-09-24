class StringCalculator {
  int add(String numbers) {
    if (numbers.trim().isEmpty) return 0;

    String delimiterPattern = '[,\\n]';

    // Check for custom delimiter at the beginning
    if (numbers.startsWith('//')) {
      final splitIndex = numbers.indexOf('\n');
      if (splitIndex != -1) {
        final delimiterLine = numbers.substring(2, splitIndex);
        final customDelimiter = RegExp.escape(delimiterLine);
        delimiterPattern = customDelimiter;
        numbers = numbers.substring(splitIndex + 1);
      }
    }

    final parts = numbers
        .split(RegExp(delimiterPattern))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    int sum = 0;
    for (final p in parts) {
      sum += int.parse(p);
    }
    return sum;
  }
}
