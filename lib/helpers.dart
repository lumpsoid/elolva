/// Counts the number of digits in an integer.
///
/// Takes an [number] as input, converts its absolute value to a string,
/// and returns the count of digits in the number.
///
/// Example:
/// ```dart
/// int number = 12345;
/// int digitCount = countDigits(number);
/// print('The number of digits in $number is $digitCount.');
/// ```
int countDigits(int number) {
  // Convert the number to a string and get its length
  return number.abs().toString().length;
}

Future<int> convertToInt(String number) async {
  try {
    int microseconds = int.parse(number);
    return microseconds;
  } catch (e) {
    throw FormatException("Error parsing string to integer: $e");
  }
}