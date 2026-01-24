/// Utility class for masking sensitive document numbers
class DocumentMasker {
  /// Masks an Aadhar number, showing only last 4 digits
  /// 
  /// Example: `123456789012` → `XXXX-XXXX-9012`
  static String maskAadhar(String aadharNum) {
    if (aadharNum.length != 12) {
      return aadharNum; // Return as-is if invalid length
    }
    
    final last4 = aadharNum.substring(8);
    return 'XXXX-XXXX-$last4';
  }
  
  /// Masks a PAN number, showing only last 4 characters
  /// 
  /// Example: `ABCDE1234F` → `XXXXXX234F`
  static String maskPAN(String panNum) {
    if (panNum.length != 10) {
      return panNum; // Return as-is if invalid length
    }
    
    final last4 = panNum.substring(6);
    return 'XXXXXX$last4';
  }
  
  /// Masks a GSTIN, showing only state code and last 4 characters
  /// 
  /// Example: `27AABCU9603R1ZM` → `27XXXXXXXXXR1ZM`
  static String maskGSTIN(String gstinNum) {
    if (gstinNum.length != 15) {
      return gstinNum; // Return as-is if invalid length
    }
    
    final stateCode = gstinNum.substring(0, 2);
    final last4 = gstinNum.substring(11);
    return '${stateCode}XXXXXXXXX$last4';
  }
  
  /// Masks any document based on its type
  /// 
  /// Automatically detects document type and applies appropriate masking
  static String maskDocument(String documentNum) {
    if (documentNum.length == 12 && RegExp(r'^\d{12}$').hasMatch(documentNum)) {
      return maskAadhar(documentNum);
    } else if (documentNum.length == 10 && RegExp(r'^[A-Z]{5}\d{4}[A-Z]$').hasMatch(documentNum)) {
      return maskPAN(documentNum);
    } else if (documentNum.length == 15) {
      return maskGSTIN(documentNum);
    }
    
    // Default masking: show first 2 and last 4 characters
    if (documentNum.length > 6) {
      final first2 = documentNum.substring(0, 2);
      final last4 = documentNum.substring(documentNum.length - 4);
      final masked = 'X' * (documentNum.length - 6);
      return '$first2$masked$last4';
    }
    
    return documentNum;
  }
}
