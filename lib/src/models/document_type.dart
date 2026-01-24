/// Enum representing different types of Indian government documents
enum DocumentType {
  /// Aadhar Card - 12 digit unique identification number
  aadhar,
  
  /// PAN Card - 10 character alphanumeric tax identification
  pan,
  
  /// GST Identification Number - 15 character alphanumeric
  gstin,
  
  /// Unknown or unsupported document type
  unknown,
}

/// Extension methods for DocumentType enum
extension DocumentTypeExtension on DocumentType {
  /// Returns human-readable name of the document type
  String get displayName {
    switch (this) {
      case DocumentType.aadhar:
        return 'Aadhar Card';
      case DocumentType.pan:
        return 'PAN Card';
      case DocumentType.gstin:
        return 'GSTIN';
      case DocumentType.unknown:
        return 'Unknown';
    }
  }
  
  /// Returns the expected length of the document number
  int get expectedLength {
    switch (this) {
      case DocumentType.aadhar:
        return 12;
      case DocumentType.pan:
        return 10;
      case DocumentType.gstin:
        return 15;
      case DocumentType.unknown:
        return 0;
    }
  }
}
