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

    // Parse numbers and check for negatives
    List<int> nums = parts.map(int.parse).toList();
    List<int> negatives = nums.where((n) => n < 0).toList();

    if (negatives.isNotEmpty) {
      throw FormatException('Negatives not allowed: ${negatives.join(", ")}');
    }

    // Sum numbers
    int sum = nums.fold(0, (prev, n) => prev + n);
    return sum;
  }
}
