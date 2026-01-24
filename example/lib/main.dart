import 'package:flutter/material.dart';
import 'package:govt_documents_validator/govt_documents_validator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final GSTValidator gstValidator = GSTValidator();
  final AadharValidator aadharValidator = AadharValidator();
  final PANValidator panValidator = PANValidator();
  
  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All documents validated successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Document Validation",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Validate Indian Government Documents',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              
              // Aadhar Field
              TextFormField(
                maxLength: 12,
                keyboardType: TextInputType.number,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  labelText: 'Aadhar Number',
                  hintText: '1234-5678-9012',
                  prefixIcon: const Icon(Icons.credit_card),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Aadhar number';
                  }
                  if (!aadharValidator.validate(value)) {
                    return 'Invalid Aadhar number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              // PAN Field
              TextFormField(
                maxLength: 10,
                textCapitalization: TextCapitalization.characters,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  labelText: 'PAN Number',
                  hintText: 'ABCDE1234F',
                  prefixIcon: const Icon(Icons.account_box),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter PAN number';
                  }
                  if (!panValidator.validate(value)) {
                    return 'Invalid PAN number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              // GST Field
              TextFormField(
                maxLength: 15,
                textCapitalization: TextCapitalization.characters,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  labelText: 'GST Number',
                  hintText: '27AABCU9603R1ZM',
                  prefixIcon: const Icon(Icons.business),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter GST number';
                  }
                  if (!gstValidator.validate(value)) {
                    return 'Invalid GST number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              
              // Submit Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 30.0,
                  ),
                ),
                onPressed: _submit,
                child: const Text(
                  "Validate Documents",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Feature showcase
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Package Features:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildFeatureItem('✓ Aadhar validation (Verhoeff algorithm)'),
                      _buildFeatureItem('✓ PAN validation'),
                      _buildFeatureItem('✓ GST validation (Luhn mod 36)'),
                      _buildFeatureItem('✓ Document masking'),
                      _buildFeatureItem('✓ Document formatting'),
                      _buildFeatureItem('✓ Batch validation'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
