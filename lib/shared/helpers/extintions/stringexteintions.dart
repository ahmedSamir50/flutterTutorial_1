extension StringExtensions on String {
  bool containsIgnoreCase(String secondString) => toLowerCase().contains(secondString.toLowerCase());

   bool isNotBlank() => isNotEmpty && trim().isNotEmpty;
}