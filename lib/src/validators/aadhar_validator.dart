// Verhoeff algorithm lookup tables for Aadhar validation
const _mult = [
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
  [1, 2, 3, 4, 0, 6, 7, 8, 9, 5],
  [2, 3, 4, 0, 1, 7, 8, 9, 5, 6],
  [3, 4, 0, 1, 2, 8, 9, 5, 6, 7],
  [4, 0, 1, 2, 3, 9, 5, 6, 7, 8],
  [5, 9, 8, 7, 6, 0, 4, 3, 2, 1],
  [6, 5, 9, 8, 7, 1, 0, 4, 3, 2],
  [7, 6, 5, 9, 8, 2, 1, 0, 4, 3],
  [8, 7, 6, 5, 9, 3, 2, 1, 0, 4],
  [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
];

const _perm = [
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
  [1, 5, 7, 6, 2, 8, 3, 0, 9, 4],
  [5, 8, 0, 3, 7, 9, 6, 1, 4, 2],
  [8, 9, 1, 6, 0, 4, 3, 5, 2, 7],
  [9, 4, 5, 3, 1, 2, 6, 8, 7, 0],
  [4, 2, 8, 6, 5, 7, 3, 9, 0, 1],
  [2, 7, 9, 3, 8, 0, 6, 4, 1, 5],
  [7, 0, 4, 6, 9, 1, 3, 2, 5, 8]
];

/// Validator for Indian Aadhar Card numbers
/// 
/// Aadhar is a 12-digit unique identification number issued by UIDAI.
/// Validation uses the Verhoeff algorithm for checksum verification.
class AadharValidator {
  /// Validates an Aadhar number using the Verhoeff algorithm
  /// 
  /// Returns true if the Aadhar number is valid, false otherwise
  /// 
  /// Example:
  /// ```dart
  /// AadharValidator validator = AadharValidator();
  /// bool isValid = validator.validate('234123412346'); // true or false
  /// ```
  bool validate(String aadharNum) {
    if (aadharNum.length == 12 && RegExp(r'^[0-9]+$').hasMatch(aadharNum)) {
      try {
        int i = aadharNum.length;
        int j = 0;
        int x = 0;
        
        while (i > 0) {
          i -= 1;
          String curr = aadharNum[i];
          var index = int.parse(curr);
          x = _mult[x][_perm[(j % 8)][index]];
          j += 1;
        }
        
        return x == 0;
      } on Exception catch (_) {
        return false;
      }
    }
    return false;
  }
}
