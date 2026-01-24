/// Utility class for formatting document numbers with proper separators
class DocumentFormatter {
  /// Formats an Aadhar number with hyphens
  /// 
  /// Example: `123456789012` → `1234-5678-9012`
  static String formatAadhar(String aadharNum) {
    // Remove any existing formatting
    final cleaned = aadharNum.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cleaned.length != 12) {
      return aadharNum; // Return as-is if invalid length
    }
    
    return '${cleaned.substring(0, 4)}-${cleaned.substring(4, 8)}-${cleaned.substring(8)}';
  }
  
  /// Formats a PAN number (no standard formatting, returns uppercase)
  /// 
  /// Example: `abcde1234f` → `ABCDE1234F`
  static String formatPAN(String panNum) {
    return panNum.toUpperCase();
  }
  
  /// Formats a GSTIN with hyphens for readability
  /// 
  /// Example: `27AABCU9603R1ZM` → `27-AABCU9603R-1Z-M`
  static String formatGSTIN(String gstinNum) {
    // Remove any existing formatting
    final cleaned = gstinNum.replaceAll(RegExp(r'[^A-Z0-9]'), '').toUpperCase();
    
    if (cleaned.length != 15) {
      return gstinNum; // Return as-is if invalid length
    }
    
    // Format: XX-XXXXXXXXXX-XX-X (State-PAN-Entity-Checksum)
    return '${cleaned.substring(0, 2)}-${cleaned.substring(2, 12)}-${cleaned.substring(12, 14)}-${cleaned.substring(14)}';
  }
  
  /// Removes all formatting from a document number
  /// 
  /// Useful for cleaning user input before validation
  static String cleanDocument(String documentNum) {
    return documentNum.replaceAll(RegExp(r'[^A-Z0-9]'), '').toUpperCase();
  }
  
  /// Formats any document based on its type
  /// 
  /// Automatically detects document type and applies appropriate formatting
  static String formatDocument(String documentNum) {
    final cleaned = cleanDocument(documentNum);
    
    if (cleaned.length == 12 && RegExp(r'^\d{12}$').hasMatch(cleaned)) {
      return formatAadhar(cleaned);
    } else if (cleaned.length == 10 && RegExp(r'^[A-Z]{5}\d{4}[A-Z]$').hasMatch(cleaned)) {
      return formatPAN(cleaned);
    } else if (cleaned.length == 15) {
      return formatGSTIN(cleaned);
    }
    
    return documentNum;
  }
}
