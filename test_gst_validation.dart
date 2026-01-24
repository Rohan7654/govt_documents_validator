import 'package:govt_documents_validator/govt_documents_validator.dart';

void main() {
  final gstValidator = GSTValidator();
  
  print('=== GST Validation Tests ===\n');
  
  // Valid GSTIN test cases from research
  final validGSTINs = [
    '27AABCU9603R1ZM',
    '07AAACR5055K1Z5',
    '29GGGGG1314R9Z6',
    '27AAAPA1234A1Z5',
    '27ABCDE1234F2Z5',
  ];
  
  print('Testing VALID GSTINs:');
  for (final gstin in validGSTINs) {
    final result = gstValidator.validate(gstin);
    print('  $gstin: ${result ? "✓ VALID" : "✗ INVALID (EXPECTED VALID)"}');
  }
  
  print('\nTesting INVALID GSTINs:');
  
  // Invalid test cases
  final invalidGSTINs = {
    '27ABCDE1234F2Z6': 'Wrong checksum',
    '27ABCDF1234F2Z5': 'Modified PAN',
    '99AABCU9603R1ZM': 'Invalid state code (99)',
    '00AABCU9603R1ZM': 'Invalid state code (00)',
    '27AABCU9603R1Z': 'Too short (14 chars)',
    '27AABCU9603R1ZMX': 'Too long (16 chars)',
    '': 'Empty string',
    '27aabcu9603r1zm': 'Lowercase (should auto-convert)',
    '27AABCU9603R1XM': 'Wrong 14th character (not Z)',
    'AB27AABCU9603R1ZM': 'Invalid format',
  };
  
  invalidGSTINs.forEach((gstin, description) {
    final result = gstValidator.validate(gstin);
    final status = !result ? "✓ INVALID" : "✗ VALID (EXPECTED INVALID)";
    print('  $gstin: $status - $description');
  });
  
  // Test case-insensitivity (lowercase should work)
  print('\nTesting case-insensitivity:');
  final lowercaseGSTIN = '27aabcu9603r1zm';
  final lowercaseResult = gstValidator.validate(lowercaseGSTIN);
  print('  $lowercaseGSTIN: ${lowercaseResult ? "✓ VALID (auto-converted to uppercase)" : "✗ INVALID"}');
  
  print('\n=== Tests Complete ===');
}
