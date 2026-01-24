/// Validator for Indian PAN (Permanent Account Number)
/// 
/// PAN is a 10-character alphanumeric identifier issued by the Income Tax Department.
/// Format: 5 letters + 4 digits + 1 letter (e.g., ABCDE1234F)
class PANValidator {
  /// Validates a PAN number based on format
  /// 
  /// Returns true if the PAN format is valid, false otherwise
  /// 
  /// Example:
  /// ```dart
  /// PANValidator validator = PANValidator();
  /// bool isValid = validator.validate('ABCDE1234F'); // true
  /// ```
  bool validate(String panNum) {
    final RegExp re = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
    
    if (panNum.length == 10) {
      // Convert to uppercase for validation
      final upperPAN = panNum.toUpperCase();
      return re.hasMatch(upperPAN);
    }
    
    return false;
  }
}
