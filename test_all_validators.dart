import 'package:govt_documents_validator/govt_documents_validator.dart';

void main() {
  print('═══════════════════════════════════════════════════════════════');
  print('     INDIAN GOVERNMENT DOCUMENTS VALIDATOR - TEST SUITE');
  print('═══════════════════════════════════════════════════════════════\n');
  
  testAadharValidator();
  print('\n');
  testPANValidator();
  print('\n');
  testGSTValidator();
  
  print('\n═══════════════════════════════════════════════════════════════');
  print('                    ALL TESTS COMPLETE');
  print('═══════════════════════════════════════════════════════════════');
}

void testAadharValidator() {
  final validator = AadharValidator();
  
  print('┌─────────────────────────────────────────────────────────────┐');
  print('│                  AADHAR VALIDATOR TESTS                     │');
  print('└─────────────────────────────────────────────────────────────┘\n');
  
  // Valid Aadhar numbers (using Verhoeff algorithm)
  final validAadhars = [
    '234123412346',  // Valid checksum
    '123456789012',  // Example valid
    '999999990019',  // Valid checksum
  ];
  
  print('✓ Testing VALID Aadhar Numbers:');
  for (final aadhar in validAadhars) {
    final result = validator.validate(aadhar);
    print('  ${result ? "✓" : "✗"} $aadhar: ${result ? "VALID" : "INVALID (EXPECTED VALID)"}');
  }
  
  print('\n✗ Testing INVALID Aadhar Numbers:');
  
  final invalidAadhars = {
    '123456789013': 'Wrong checksum',
    '12345678901': 'Too short (11 digits)',
    '1234567890123': 'Too long (13 digits)',
    '': 'Empty string',
    '12345678901a': 'Contains letter',
    '123 456 789 012': 'Contains spaces',
    '000000000000': 'All zeros',
    '1234-5678-9012': 'Contains hyphens',
  };
  
  invalidAadhars.forEach((aadhar, description) {
    final result = validator.validate(aadhar);
    final status = !result ? "✓" : "✗";
    print('  $status $aadhar: ${!result ? "INVALID" : "VALID (EXPECTED INVALID)"} - $description');
  });
}

void testPANValidator() {
  final validator = PANValidator();
  
  print('┌─────────────────────────────────────────────────────────────┐');
  print('│                    PAN VALIDATOR TESTS                      │');
  print('└─────────────────────────────────────────────────────────────┘\n');
  
  // Valid PAN numbers (format: AAAAA9999A)
  final validPANs = [
    'ABCDE1234F',
    'AAAAA1111A',
    'BBBBB2222B',
    'CCCCC3333C',
    'DDDDD4444D',
    'EEEEE5555E',
  ];
  
  print('✓ Testing VALID PAN Numbers:');
  for (final pan in validPANs) {
    final result = validator.validate(pan);
    print('  ${result ? "✓" : "✗"} $pan: ${result ? "VALID" : "INVALID (EXPECTED VALID)"}');
  }
  
  print('\n✗ Testing INVALID PAN Numbers:');
  
  final invalidPANs = {
    'ABCDE1234': 'Too short (9 chars)',
    'ABCDE1234FF': 'Too long (11 chars)',
    '': 'Empty string',
    'abcde1234f': 'Lowercase letters',
    'ABCD11234F': 'Only 4 letters at start',
    'ABCDEF1234F': 'Too many letters at start',
    'ABCDE12345': 'Last char is digit',
    '12345ABCDE': 'Wrong format',
    'ABCDE-1234F': 'Contains hyphen',
    'ABCDE 1234F': 'Contains space',
  };
  
  invalidPANs.forEach((pan, description) {
    final result = validator.validate(pan);
    final status = !result ? "✓" : "✗";
    print('  $status $pan: ${!result ? "INVALID" : "VALID (EXPECTED INVALID)"} - $description');
  });
}

void testGSTValidator() {
  final validator = GSTValidator();
  
  print('┌─────────────────────────────────────────────────────────────┐');
  print('│                   GST VALIDATOR TESTS                       │');
  print('└─────────────────────────────────────────────────────────────┘\n');
  
  // Valid GSTIN numbers (verified with Luhn mod 36)
  final validGSTINs = [
    '27AABCU9603R1ZM',
    '07AAACR5055K1Z5',
    '29GGGGG1314R9Z6',
    '27AAAPA1234A1Z5',
    '27ABCDE1234F2Z5',
  ];
  
  print('✓ Testing VALID GSTIN Numbers:');
  for (final gstin in validGSTINs) {
    final result = validator.validate(gstin);
    print('  ${result ? "✓" : "✗"} $gstin: ${result ? "VALID" : "INVALID (EXPECTED VALID)"}');
  }
  
  print('\n✗ Testing INVALID GSTIN Numbers:');
  
  final invalidGSTINs = {
    '27ABCDE1234F2Z6': 'Wrong checksum digit',
    '27ABCDF1234F2Z5': 'Modified PAN portion',
    '99AABCU9603R1ZM': 'Invalid state code (99)',
    '00AABCU9603R1ZM': 'Invalid state code (00)',
    '27AABCU9603R1Z': 'Too short (14 chars)',
    '27AABCU9603R1ZMX': 'Too long (16 chars)',
    '': 'Empty string',
    '27AABCU9603R1XM': 'Wrong 14th character (not Z)',
    'AB27AABCU9603R1ZM': 'Invalid format - starts with letters',
    '27aabcu9603r1zm': 'Lowercase (should auto-convert)',
    '27-AABCU-9603R1ZM': 'Contains hyphens',
    '27 AABCU 9603R1ZM': 'Contains spaces',
    '27AABCU96031ZM': 'Missing digit in PAN',
    '27AABCU9603R0ZM': 'Entity code is 0 (invalid)',
  };
  
  invalidGSTINs.forEach((gstin, description) {
    final result = validator.validate(gstin);
    final status = !result ? "✓" : "✗";
    print('  $status $gstin: ${!result ? "INVALID" : "VALID (EXPECTED INVALID)"} - $description');
  });
  
  // Special test: Case insensitivity
  print('\n🔄 Testing Case Insensitivity:');
  final lowercaseGSTIN = '27aabcu9603r1zm';
  final lowercaseResult = validator.validate(lowercaseGSTIN);
  print('  ${lowercaseResult ? "✓" : "✗"} $lowercaseGSTIN: ${lowercaseResult ? "VALID (auto-converted)" : "INVALID"}');
}
