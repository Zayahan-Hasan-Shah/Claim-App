// features/claims/presentation/screens/add_claim_screen.dart
import 'package:claim_app/features/claim/data/models/claim_model.dart';
import 'package:claim_app/features/claim/presentation/controllers/claim_controller.dart';
import 'package:claim_app/features/claim/presentation/controllers/claim_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:claim_app/core/widgets/custom_button.dart';
import 'package:claim_app/core/widgets/custom_textfield.dart';
import 'package:claim_app/core/widgets/loading_indicator.dart';
import 'package:claim_app/core/utils/validators.dart';
import 'package:claim_app/navigation/route_names.dart';

class AddClaimScreen extends ConsumerStatefulWidget {
  const AddClaimScreen({super.key});

  @override
  ConsumerState<AddClaimScreen> createState() => _AddClaimScreenState();
}

class _AddClaimScreenState extends ConsumerState<AddClaimScreen> {
  final _formKey = GlobalKey<FormState>();
  final _memberNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _cnicController = TextEditingController();
  final _addressController = TextEditingController();

  ClaimType _selectedType = ClaimType.hospitality;
  final _amountController = TextEditingController();
  final _hospitalNameController = TextEditingController();
  final _admissionDateController = TextEditingController();
  final _dischargeDateController = TextEditingController();
  final _dateController = TextEditingController();

  RelationType _selectedRelation = RelationType.spouse;

  String? _billPath;
  DateTime? _admissionDate;
  DateTime? _dischargeDate;
  DateTime? _date;

  @override
  void dispose() {
    _memberNameController.dispose();
    _ageController.dispose();
    _cnicController.dispose();
    _addressController.dispose();
    _amountController.dispose();
    _hospitalNameController.dispose();
    _admissionDateController.dispose();
    _dischargeDateController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final claimState = ref.watch(claimControllerProvider);

    ref.listen<ClaimState>(claimControllerProvider, (previous, next) {
      if (next is ClaimError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }
      if (next is ClaimLoaded) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Claim submitted successfully')),
        );
        context.go(RouteNames.claimList);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Add New Claim')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Member Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _memberNameController,
                label: 'Member Name',
                validator: (value) => Validators.required(value, 'Member name'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<RelationType>(
                value: _selectedRelation,
                decoration: const InputDecoration(
                  labelText: 'Relation',
                  border: OutlineInputBorder(),
                ),
                items: RelationType.values.map((relation) {
                  return DropdownMenuItem<RelationType>(
                    value: relation,
                    child: Text(relation.name),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedRelation = value;
                    });
                  }
                },
                validator: (value) {
                  if (value == null) return 'Please select a relation';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _ageController,
                label: 'Age',
                validator: (value) => Validators.required(value, 'Age'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _cnicController,
                label: 'CNIC/B-Form Number',
                validator: Validators.cnic,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _addressController,
                label: 'Address',
                validator: (value) => Validators.required(value, 'Address'),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              const Text('Claim Type',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<ClaimType>(
                value: _selectedType,
                items: ClaimType.values.map((type) {
                  return DropdownMenuItem<ClaimType>(
                    value: type,
                    child: Text(type.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              _buildClaimTypeFields(),
              const SizedBox(height: 24),
              _buildBillUploadSection(),
              const SizedBox(height: 32),
              claimState is ClaimLoading
                  ? const LoadingIndicator()
                  : Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: 'Add Another Claim',
                            onPressed: () => _submitClaim(false),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomButton(
                            text: 'Submit',
                            onPressed: () => _submitClaim(true),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClaimTypeFields() {
    switch (_selectedType) {
      case ClaimType.hospitality:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hospitality Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _amountController,
              label: 'Amount',
              validator: Validators.amount,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _hospitalNameController,
              label: 'Hospital Name',
              validator: (value) => Validators.required(value, 'Hospital name'),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _admissionDateController,
              label: 'Admission Date',
              validator: (value) =>
                  Validators.required(value, 'Admission date'),
              readOnly: true,
              onTap: () => _selectDate(context, true),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _dischargeDateController,
              label: 'Discharge Date',
              validator: (value) =>
                  Validators.required(value, 'Discharge date'),
              readOnly: true,
              onTap: () => _selectDate(context, false),
            ),
          ],
        );
      case ClaimType.opd:
      case ClaimType.dentist:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${_selectedType.toString().split('.').last} Details',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _amountController,
              label: 'Amount',
              validator: Validators.amount,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _dateController,
              label: 'Date',
              validator: (value) => Validators.required(value, 'Date'),
              readOnly: true,
              onTap: () => _selectDate(context, null),
            ),
          ],
        );
    }
  }

  Widget _buildBillUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Upload Bill',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('File should not exceed 2MB',
            style: TextStyle(color: Colors.grey[600])),
        const SizedBox(height: 16),
        _billPath == null
            ? CustomButton(
                text: 'Select File',
                onPressed: _pickFile,
                outlined: true,
              )
            : Row(
                children: [
                  Expanded(
                    child: Text(
                      _billPath!.split('/').last,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _billPath = null;
                      });
                    },
                  ),
                ],
              ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context, bool? isAdmissionDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        if (isAdmissionDate == null) {
          _date = picked;
          _dateController.text = '${picked.day}/${picked.month}/${picked.year}';
        } else if (isAdmissionDate) {
          _admissionDate = picked;
          _admissionDateController.text =
              '${picked.day}/${picked.month}/${picked.year}';
        } else {
          _dischargeDate = picked;
          _dischargeDateController.text =
              '${picked.day}/${picked.month}/${picked.year}';
        }
      });
    }
  }

  Future<void> _pickFile() async {
    final ImagePicker picker = ImagePicker();
    try {
      // For mobile, we'll use image_picker to get a file
      final XFile? file = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 90,
      );

      if (file != null) {
        // Check file size (2MB limit)
        final fileSize = await file.length();
        const maxSize = 2 * 1024 * 1024; // 2MB in bytes

        if (fileSize > maxSize) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('File size exceeds 2MB limit')),
          );
          return;
        }

        setState(() {
          _billPath = file.path;
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error selecting file: ${e.toString()}')),
      );
    }
  }

  // Updated _submitClaim function in add_claim_screen.dart
  Future<void> _submitClaim(bool shouldSubmit) async {
    if (_formKey.currentState!.validate() && _billPath != null) {
      final claim = Claim(
        memberName: _memberNameController.text,
        relation: _selectedRelation,
        age: int.parse(_ageController.text),
        cnic: _cnicController.text,
        address: _addressController.text,
        type: _selectedType,
        amount: double.parse(_amountController.text),
        hospitalName: _hospitalNameController.text,
        admissionDate: _admissionDate,
        dischargeDate: _dischargeDate,
        date: _date ?? DateTime.now(),
        billPath: _billPath!,
        status: ClaimStatus.pending,
        submittedAt: DateTime.now(),
      );

      final claimController = ref.read(claimControllerProvider.notifier);

      // Always add the claim to pending claims
      await claimController.addClaim(claim);

      if (shouldSubmit) {
        // Get all pending claims from the state
        final currentState = ref.read(claimControllerProvider);
        if (currentState is ClaimLoaded) {
          final pendingClaims = currentState.claims
              .where((c) => c.status == ClaimStatus.pending)
              .toList();

          // Submit all pending claims
          await claimController.submitClaims(pendingClaims);
        }
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Claim added successfully')),
        );
        _resetForm();
      }
    } else if (_billPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload a bill')),
      );
    }
  }

  void _resetForm() {
    _memberNameController.clear();
    _ageController.clear();
    _cnicController.clear();
    _addressController.clear();
    _amountController.clear();
    _hospitalNameController.clear();
    _admissionDateController.clear();
    _dischargeDateController.clear();
    _dateController.clear();
    setState(() {
      _billPath = null;
      _admissionDate = null;
      _dischargeDate = null;
      _date = null;
    });
  }
}
