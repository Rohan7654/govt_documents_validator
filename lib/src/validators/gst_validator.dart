// Helper function for summing list elements
int _listElementsSum(List<int> a) {
  if (a.isEmpty) return 0;
  if (a.length == 1) return a[0];
  
  int sum = 0;
  for (int e in a) {
    sum += e;
  }
  return sum;
}

/// Validator for Indian GST Identification Number (GSTIN)
/// 
/// GSTIN Structure (15 characters):
/// - First 2 digits: State Code (01-38)
/// - Next 10 characters: PAN of the taxpayer
/// - 13th character: Entity Code (1-9 or A-Z)
/// - 14th character: Default character (usually 'Z')
/// - 15th character: Checksum digit (calculated using Luhn mod 36 algorithm)
class GSTValidator {
  /// Validates a GST number using format validation and Luhn mod 36 checksum algorithm
  /// 
  /// Returns true if the GSTIN is valid, false otherwise
  /// 
  /// Example:
  /// ```dart
  /// GSTValidator validator = GSTValidator();
  /// bool isValid = validator.validate('27AABCU9603R1ZM'); // true
  /// ```
  bool validate(String gstNum) {
    // Basic format validation
    if (gstNum.isEmpty || gstNum.length != 15) {
      return false;
    }

    // Convert to uppercase for consistent validation
    gstNum = gstNum.toUpperCase();

    // Validate GSTIN format using regex
    // Format: 2 digits (state code) + 10 alphanumeric (PAN) + 1 alphanumeric (entity) + 1 char (Z) + 1 alphanumeric (checksum)
    final gstinPattern = RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$');
    
    if (!gstinPattern.hasMatch(gstNum)) {
      return false;
    }

    // Validate state code (01-38 are valid Indian state codes)
    final stateCode = int.tryParse(gstNum.substring(0, 2));
    if (stateCode == null || stateCode < 1 || stateCode > 38) {
      return false;
    }

    // Extract checksum character (15th character)
    final checksumChar = gstNum[14];
    
    // Extract first 14 characters for checksum calculation
    final first14Chars = gstNum.substring(0, 14);
    
    // Convert characters to numeric values (0-9 = 0-9, A-Z = 10-35)
    final List<int> numericValues = [];
    for (int i = 0; i < first14Chars.length; i++) {
      final char = first14Chars[i];
      if (RegExp(r'^[0-9]$').hasMatch(char)) {
        numericValues.add(int.parse(char));
      } else {
        // A=10, B=11, ..., Z=35
        numericValues.add(char.codeUnitAt(0) - 55);
      }
    }
    
    // Apply Luhn mod 36 algorithm
    // Multiply each value by alternating factors (1, 2, 1, 2, ...)
    final List<int> products = [];
    for (int i = 0; i < numericValues.length; i++) {
      final multiplier = (i % 2) + 1; // Alternates between 1 and 2
      products.add(numericValues[i] * multiplier);
    }
    
    // For each product, calculate quotient + remainder when divided by 36
    final List<int> hashValues = [];
    for (int product in products) {
      final quotient = product ~/ 36;
      final remainder = product % 36;
      hashValues.add(quotient + remainder);
    }
    
    // Sum all hash values
    final int totalSum = _listElementsSum(hashValues);
    
    // Calculate checksum: 36 - (sum % 36)
    int checksumValue = 36 - (totalSum % 36);
    
    // Handle special case: if checksum is 36, it should be 0
    if (checksumValue == 36) {
      checksumValue = 0;
    }
    
    // Convert checksum value to character (0-9 or A-Z)
    final String calculatedChecksum = checksumValue < 10 
        ? checksumValue.toString() 
        : String.fromCharCode(checksumValue + 55);
    
    // Compare calculated checksum with actual checksum
    return calculatedChecksum == checksumChar;
  }
}
