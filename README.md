# govt_documents_validator

This package provides an easy way to validate Indian Government Documents like Aadhar,PAN and GSTIN. This is often useful to avoid the use of RegEx for validating the user inputs which maynot work in some scenarios, this package written purely in dart will validate the numbers through CheckSum values.

## Example usage in User Forms


# Using AadharValidator
For verifying Goverment Document inputs in User Forms use the simple functions provided by this package.
```dart
import 'package:govt_documents_validator/govt_documents_validator.dart';
bool isAadharNum;
String aadharNumber = 'xxxxxxxxxxxx';
AadharValidator aadharValidator = new AadharValidator();
isAadharNum = aadharValidator.validate(aadharNumber);
```

# Using GSTValidator
For verifying Goverment Document inputs in User Forms use the simple functions provided by this package.
```dart
import 'package:govt_documents_validator/govt_documents_validator.dart';
bool isGSTNum;
String gstNumber = 'xxxxxxxxxxxxxx';
GSTValidator gstValidator = new GSTValidator();
isGSTNum = gstValidator.validate(aadharNumber);
```
# Using PANValidator
For verifying Goverment Document inputs in User Forms use the simple functions provided by this package.
```dart
import 'package:govt_documents_validator/govt_documents_validator.dart';
bool isPAnNum;
String panNumber = 'xxxxxxxxxx';
PANValidator panValidator = new PANValidator();
isPAnNum = panValidator.validate(aadharNumber);
```
