class StringCalculator {
  int add(String numbers) {
    if (numbers.trim().isEmpty) return 0;

    String delimiterPattern = '[,\\n]'; // default delimiters: comma or newline

    // Check for custom delimiter at the beginning
    if (numbers.startsWith('//')) {
      final splitIndex = numbers.indexOf('\n');
      if (splitIndex != -1) {
        final delimiterLine = numbers.substring(2, splitIndex);

        // Support delimiters of any length using [delimiter] format
        if (delimiterLine.startsWith('[') && delimiterLine.endsWith(']')) {
          final customDelimiter =
              delimiterLine.substring(1, delimiterLine.length - 1);
          delimiterPattern = RegExp.escape(customDelimiter);
        } else {
          // single-character delimiter (old format)
          delimiterPattern = RegExp.escape(delimiterLine);
        }

        numbers = numbers.substring(splitIndex + 1); // remove delimiter line
      }
    }

    // Split numbers using delimiter(s)
    final parts = numbers
        .split(RegExp(delimiterPattern))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    // Parse numbers
    List<int> nums = parts.map(int.parse).toList();

    // Check for negatives
    List<int> negatives = nums.where((n) => n < 0).toList();
    if (negatives.isNotEmpty) {
      throw FormatException('Negatives not allowed: ${negatives.join(", ")}');
    }

    // Ignore numbers greater than 1000
    nums = nums.where((n) => n <= 1000).toList();

    // Sum numbers
    int sum = nums.fold(0, (prev, n) => prev + n);
    return sum;
  }
}
