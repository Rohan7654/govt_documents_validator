import '../models/validation_result.dart';
import '../models/document_type.dart';
import '../validators/aadhar_validator.dart';
import '../validators/pan_validator.dart';
import '../validators/gst_validator.dart';

/// Utility class for batch validation of multiple documents
class BatchValidator {
  final _aadharValidator = AadharValidator();
  final _panValidator = PANValidator();
  final _gstValidator = GSTValidator();
  
  /// Validates multiple documents at once
  /// 
  /// Returns a map of document numbers to their validation results
  /// 
  /// Example:
  /// ```dart
  /// final results = BatchValidator().validateAll({
  ///   'aadhar': '123456789012',
  ///   'pan': 'ABCDE1234F',
  ///   'gst': '27AABCU9603R1ZM',
  /// });
  /// ```
  Map<String, bool> validateAll(Map<String, String> documents) {
    final results = <String, bool>{};
    
    documents.forEach((key, value) {
      final type = _detectDocumentType(value);
      bool isValid = false;
      
      switch (type) {
        case DocumentType.aadhar:
          isValid = _aadharValidator.validate(value);
          break;
        case DocumentType.pan:
          isValid = _panValidator.validate(value);
          break;
        case DocumentType.gstin:
          isValid = _gstValidator.validate(value);
          break;
        case DocumentType.unknown:
          isValid = false;
          break;
      }
      
      results[key] = isValid;
    });
    
    return results;
  }
  
  /// Validates multiple documents with detailed results
  /// 
  /// Returns a map of document numbers to ValidationResult objects
  Map<String, ValidationResult> validateAllDetailed(Map<String, String> documents) {
    final results = <String, ValidationResult>{};
    
    documents.forEach((key, value) {
      final type = _detectDocumentType(value);
      ValidationResult result;
      
      switch (type) {
        case DocumentType.aadhar:
          final isValid = _aadharValidator.validate(value);
          result = isValid
              ? ValidationResult.success(DocumentType.aadhar, value)
              : ValidationResult.failure(
                  type: DocumentType.aadhar,
                  input: value,
                  errorMessage: 'Invalid Aadhar number',
                  errorCode: ValidationErrorCodes.invalidChecksum,
                );
          break;
        case DocumentType.pan:
          final isValid = _panValidator.validate(value);
          result = isValid
              ? ValidationResult.success(DocumentType.pan, value)
              : ValidationResult.failure(
                  type: DocumentType.pan,
                  input: value,
                  errorMessage: 'Invalid PAN format',
                  errorCode: ValidationErrorCodes.invalidFormat,
                );
          break;
        case DocumentType.gstin:
          final isValid = _gstValidator.validate(value);
          result = isValid
              ? ValidationResult.success(DocumentType.gstin, value)
              : ValidationResult.failure(
                  type: DocumentType.gstin,
                  input: value,
                  errorMessage: 'Invalid GSTIN',
                  errorCode: ValidationErrorCodes.invalidChecksum,
                );
          break;
        case DocumentType.unknown:
          result = ValidationResult.failure(
            type: DocumentType.unknown,
            input: value,
            errorMessage: 'Unknown document type',
            errorCode: ValidationErrorCodes.invalidFormat,
          );
          break;
      }
      
      results[key] = result;
    });
    
    return results;
  }
  
  /// Detects the type of document based on its format
  DocumentType _detectDocumentType(String documentNum) {
    final cleaned = documentNum.replaceAll(RegExp(r'[^A-Z0-9]'), '').toUpperCase();
    
    if (cleaned.length == 12 && RegExp(r'^\d{12}$').hasMatch(cleaned)) {
      return DocumentType.aadhar;
    } else if (cleaned.length == 10 && RegExp(r'^[A-Z]{5}\d{4}[A-Z]$').hasMatch(cleaned)) {
      return DocumentType.pan;
    } else if (cleaned.length == 15 && RegExp(r'^\d{2}[A-Z]{5}\d{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$').hasMatch(cleaned)) {
      return DocumentType.gstin;
    }
    
    return DocumentType.unknown;
  }
  
  /// Detects document type for a single document
  static DocumentType detectType(String documentNum) {
    return BatchValidator()._detectDocumentType(documentNum);
  }
}
