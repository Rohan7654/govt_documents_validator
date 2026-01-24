import '../models/document_type.dart';
import '../validators/aadhar_validator.dart';
import '../validators/pan_validator.dart';
import '../validators/gst_validator.dart';
import '../utils/document_formatter.dart';
import '../utils/document_masker.dart';
import '../utils/batch_validator.dart';

/// Extension methods on String for convenient document validation
extension DocumentValidationExtensions on String {
  /// Validates if the string is a valid Aadhar number
  /// 
  /// Example: `'123456789012'.isValidAadhar()`
  bool isValidAadhar() {
    return AadharValidator().validate(this);
  }
  
  /// Validates if the string is a valid PAN number
  /// 
  /// Example: `'ABCDE1234F'.isValidPAN()`
  bool isValidPAN() {
    return PANValidator().validate(this);
  }
  
  /// Validates if the string is a valid GSTIN
  /// 
  /// Example: `'27AABCU9603R1ZM'.isValidGSTIN()`
  bool isValidGSTIN() {
    return GSTValidator().validate(this);
  }
  
  /// Detects the type of document
  /// 
  /// Example: `'ABCDE1234F'.documentType` → `DocumentType.pan`
  DocumentType get documentType {
    return BatchValidator.detectType(this);
  }
  
  /// Validates the document based on auto-detected type
  /// 
  /// Example: `'123456789012'.isValidDocument()`
  bool isValidDocument() {
    final type = documentType;
    
    switch (type) {
      case DocumentType.aadhar:
        return isValidAadhar();
      case DocumentType.pan:
        return isValidPAN();
      case DocumentType.gstin:
        return isValidGSTIN();
      case DocumentType.unknown:
        return false;
    }
  }
  
  /// Formats the document number with appropriate separators
  /// 
  /// Example: `'123456789012'.formatDocument()` → `'1234-5678-9012'`
  String formatDocument() {
    return DocumentFormatter.formatDocument(this);
  }
  
  /// Masks the document number for display
  /// 
  /// Example: `'123456789012'.maskDocument()` → `'XXXX-XXXX-9012'`
  String maskDocument() {
    return DocumentMasker.maskDocument(this);
  }
  
  /// Cleans the document number (removes formatting)
  /// 
  /// Example: `'1234-5678-9012'.cleanDocument()` → `'123456789012'`
  String cleanDocument() {
    return DocumentFormatter.cleanDocument(this);
  }
}
