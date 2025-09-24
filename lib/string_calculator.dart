class StringCalculator {
  int add(String numbers) {
    if (numbers.trim().isEmpty) return 0;

    String delimiterPattern = '[,\\n]'; // default delimiters: comma or newline

    // Check for custom delimiters at the beginning
    if (numbers.startsWith('//')) {
      final splitIndex = numbers.indexOf('\n');
      if (splitIndex != -1) {
        final delimiterLine = numbers.substring(2, splitIndex);

        // Match all delimiters in square brackets
        final regex = RegExp(r'\[(.*?)\]');
        final matches = regex.allMatches(delimiterLine);

        if (matches.isNotEmpty) {
          // Escape each delimiter and join with | for regex split
          final escapedDelimiters =
              matches.map((m) => RegExp.escape(m.group(1)!)).join('|');
          delimiterPattern = escapedDelimiters;
        } else {
          // Single-character delimiter (old format)
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
