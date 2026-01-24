import 'document_type.dart';

/// Represents the result of a document validation
class ValidationResult {
  /// Whether the document is valid
  final bool isValid;
  
  /// Type of document that was validated
  final DocumentType documentType;
  
  /// Error message if validation failed, null if valid
  final String? errorMessage;
  
  /// Error code for programmatic error handling
  final String? errorCode;
  
  /// The original input that was validated
  final String input;
  
  const ValidationResult({
    required this.isValid,
    required this.documentType,
    required this.input,
    this.errorMessage,
    this.errorCode,
  });
  
  /// Creates a successful validation result
  factory ValidationResult.success(DocumentType type, String input) {
    return ValidationResult(
      isValid: true,
      documentType: type,
      input: input,
    );
  }
  
  /// Creates a failed validation result with error details
  factory ValidationResult.failure({
    required DocumentType type,
    required String input,
    required String errorMessage,
    required String errorCode,
  }) {
    return ValidationResult(
      isValid: false,
      documentType: type,
      input: input,
      errorMessage: errorMessage,
      errorCode: errorCode,
    );
  }
  
  @override
  String toString() {
    if (isValid) {
      return 'ValidationResult(valid: true, type: ${documentType.displayName})';
    } else {
      return 'ValidationResult(valid: false, type: ${documentType.displayName}, error: $errorMessage [$errorCode])';
    }
  }
}

/// Common error codes for validation failures
class ValidationErrorCodes {
  static const String emptyInput = 'EMPTY_INPUT';
  static const String invalidLength = 'INVALID_LENGTH';
  static const String invalidFormat = 'INVALID_FORMAT';
  static const String invalidChecksum = 'INVALID_CHECKSUM';
  static const String invalidStateCode = 'INVALID_STATE_CODE';
  static const String containsInvalidCharacters = 'INVALID_CHARACTERS';
}
