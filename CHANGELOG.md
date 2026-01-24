## [1.0.0] - 2026-01-24

###  Major Release - Complete Package Rewrite

This is a major version release with breaking changes, new features, and full migration to Flutter 3.x/Dart 3.x with null-safety.

###  New Features

#### Core Validators
- **Enhanced GST Validation**: Implemented proper Luhn mod 36 algorithm with comprehensive format validation
- **Improved Aadhar Validation**: Verhoeff algorithm with better error handling
- **Enhanced PAN Validation**: Simplified logic with case-insensitive support

#### Utility Features
- **Document Masking**: Mask sensitive document numbers for secure display
  - `DocumentMasker.maskAadhar()`, `maskPAN()`, `maskGSTIN()`
- **Document Formatting**: Format documents with proper separators
  - `DocumentFormatter.formatAadhar()`, `formatPAN()`, `formatGSTIN()`
- **Batch Validation**: Validate multiple documents at once
  - `BatchValidator().validateAll()`, `validateAllDetailed()`
- **Document Type Detection**: Auto-detect document type from input
  - `BatchValidator.detectType()`

#### Developer Experience
- **String Extensions**: Convenient validation methods on String
  - `'123456789012'.isValidAadhar()`
  - `'ABCDE1234F'.isValidPAN()`
  - `'27AABCU9603R1ZM'.isValidGSTIN()`
  - `'123456789012'.maskDocument()`
  - `'123456789012'.formatDocument()`
- **Detailed Error Messages**: ValidationResult model with error codes
- **Document Type Enum**: Type-safe document type representation

###  Breaking Changes

- **SDK Requirements**: Now requires Dart >=3.0.0 and Flutter >=3.0.0
- **Null-Safety**: Full null-safety support (breaking for pre-null-safety projects)
- **Module Structure**: Reorganized into modular structure (validators, utils, models, extensions)
- **Import Changes**: Main import remains the same, but internal structure changed

###  Migration Guide

#### Old Way (v0.0.1)
```dart
import 'package:govt_documents_validator/govt_documents_validator.dart';

AadharValidator validator = new AadharValidator();
bool isValid = validator.validate('123456789012');
```

#### New Way (v1.0.0)
```dart
import 'package:govt_documents_validator/govt_documents_validator.dart';

// Option 1: Extension methods (recommended)
bool isValid = '123456789012'.isValidAadhar();

// Option 2: Original way (still works, no 'new' keyword)
AadharValidator validator = AadharValidator();
bool isValid = validator.validate('123456789012');

// Option 3: Batch validation
final results = BatchValidator().validateAll({
  'aadhar': '123456789012',
  'pan': 'ABCDE1234F',
});
```

###  Bug Fixes

- Fixed GST validation algorithm (now uses correct Luhn mod 36)
- Improved error handling in all validators
- Fixed case-sensitivity issues in PAN and GST validation

###  Documentation

- Added comprehensive dartdoc comments to all public APIs
- Created detailed examples for all new features
- Added 30+ test cases covering all validators

###  Internal Changes

- Reorganized code into modular structure
- Removed deprecated `new` keyword usage
- Improved type safety throughout
- Added const constructors where applicable
- Removed unused helper functions

---

## [0.0.1] - 2021-02-28

### Initial Release

- Basic Aadhar validation using Verhoeff algorithm
- Basic PAN validation using regex
- Basic GST validation
- Simple true/false validation responses
