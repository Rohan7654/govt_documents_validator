import 'package:govt_documents_validator/govt_documents_validator_new.dart';

void main() {
  print('═══════════════════════════════════════════════════════════════');
  print('     GOVT DOCUMENTS VALIDATOR - NEW FEATURES DEMO');
  print('═══════════════════════════════════════════════════════════════\n');
  
  demonstrateBasicValidation();
  print('\n');
  demonstrateStringExtensions();
  print('\n');
  demonstrateDocumentMasking();
  print('\n');
  demonstrateDocumentFormatting();
  print('\n');
  demonstrateBatchValidation();
  print('\n');
  demonstrateDetailedValidation();
  
  print('\n═══════════════════════════════════════════════════════════════');
  print('                    DEMO COMPLETE');
  print('═══════════════════════════════════════════════════════════════');
}

void demonstrateBasicValidation() {
  print('┌─────────────────────────────────────────────────────────────┐');
  print('│              1. BASIC VALIDATION (Original)                 │');
  print('└─────────────────────────────────────────────────────────────┘\n');
  
  final aadharValidator = AadharValidator();
  final panValidator = PANValidator();
  final gstValidator = GSTValidator();
  
  print('Aadhar: 234123412346 → ${aadharValidator.validate("234123412346")}');
  print('PAN: ABCDE1234F → ${panValidator.validate("ABCDE1234F")}');
  print('GST: 27AABCU9603R1ZM → ${gstValidator.validate("27AABCU9603R1ZM")}');
}

void demonstrateStringExtensions() {
  print('┌─────────────────────────────────────────────────────────────┐');
  print('│              2. STRING EXTENSIONS (New!)                    │');
  print('└─────────────────────────────────────────────────────────────┘\n');
  
  print('Using extension methods on String:');
  print('  "234123412346".isValidAadhar() → ${"234123412346".isValidAadhar()}');
  print('  "ABCDE1234F".isValidPAN() → ${"ABCDE1234F".isValidPAN()}');
  print('  "27AABCU9603R1ZM".isValidGSTIN() → ${"27AABCU9603R1ZM".isValidGSTIN()}');
  
  print('\nAuto-detect document type:');
  print('  "234123412346".documentType → ${"234123412346".documentType}');
  print('  "ABCDE1234F".documentType → ${"ABCDE1234F".documentType}');
  print('  "27AABCU9603R1ZM".documentType → ${"27AABCU9603R1ZM".documentType}');
  
  print('\nValidate with auto-detection:');
  print('  "234123412346".isValidDocument() → ${"234123412346".isValidDocument()}');
  print('  "ABCDE1234F".isValidDocument() → ${"ABCDE1234F".isValidDocument()}');
}

void demonstrateDocumentMasking() {
  print('┌─────────────────────────────────────────────────────────────┐');
  print('│              3. DOCUMENT MASKING (New!)                     │');
  print('└─────────────────────────────────────────────────────────────┘\n');
  
  print('Mask sensitive document numbers for display:');
  print('  Aadhar: 234123412346 → ${DocumentMasker.maskAadhar("234123412346")}');
  print('  PAN: ABCDE1234F → ${DocumentMasker.maskPAN("ABCDE1234F")}');
  print('  GST: 27AABCU9603R1ZM → ${DocumentMasker.maskGSTIN("27AABCU9603R1ZM")}');
  
  print('\nUsing extension method:');
  print('  "234123412346".maskDocument() → ${"234123412346".maskDocument()}');
  print('  "ABCDE1234F".maskDocument() → ${"ABCDE1234F".maskDocument()}');
}

void demonstrateDocumentFormatting() {
  print('┌─────────────────────────────────────────────────────────────┐');
  print('│              4. DOCUMENT FORMATTING (New!)                  │');
  print('└─────────────────────────────────────────────────────────────┘\n');
  
  print('Format documents with proper separators:');
  print('  Aadhar: 234123412346 → ${DocumentFormatter.formatAadhar("234123412346")}');
  print('  PAN: abcde1234f → ${DocumentFormatter.formatPAN("abcde1234f")}');
  print('  GST: 27aabcu9603r1zm → ${DocumentFormatter.formatGSTIN("27aabcu9603r1zm")}');
  
  print('\nClean formatted input:');
  print('  "1234-5678-9012".cleanDocument() → ${"1234-5678-9012".cleanDocument()}');
  
  print('\nUsing extension method:');
  print('  "234123412346".formatDocument() → ${"234123412346".formatDocument()}');
}

void demonstrateBatchValidation() {
  print('┌─────────────────────────────────────────────────────────────┐');
  print('│              5. BATCH VALIDATION (New!)                     │');
  print('└─────────────────────────────────────────────────────────────┘\n');
  
  final batchValidator = BatchValidator();
  
  final documents = {
    'customer_aadhar': '234123412346',
    'customer_pan': 'ABCDE1234F',
    'company_gst': '27AABCU9603R1ZM',
    'invalid_doc': '12345',
  };
  
  print('Validating multiple documents at once:');
  final results = batchValidator.validateAll(documents);
  
  results.forEach((key, isValid) {
    print('  $key: ${isValid ? "✓ VALID" : "✗ INVALID"}');
  });
  
  print('\nDetect document type:');
  print('  BatchValidator.detectType("234123412346") → ${BatchValidator.detectType("234123412346")}');
}

void demonstrateDetailedValidation() {
  print('┌─────────────────────────────────────────────────────────────┐');
  print('│              6. DETAILED VALIDATION (New!)                  │');
  print('└─────────────────────────────────────────────────────────────┘\n');
  
  final batchValidator = BatchValidator();
  
  final documents = {
    'valid_aadhar': '234123412346',
    'invalid_aadhar': '123456789013',
    'valid_pan': 'ABCDE1234F',
  };
  
  print('Get detailed validation results with error codes:');
  final detailedResults = batchValidator.validateAllDetailed(documents);
  
  detailedResults.forEach((key, result) {
    print('\n  $key:');
    print('    Valid: ${result.isValid}');
    print('    Type: ${result.documentType.displayName}');
    if (!result.isValid) {
      print('    Error: ${result.errorMessage}');
      print('    Code: ${result.errorCode}');
    }
  });
}
