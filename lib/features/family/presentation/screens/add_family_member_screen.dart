// features/family/presentation/screens/add_family_member_screen.dart
import 'package:claim_app/core/utils/validators.dart';
import 'package:claim_app/core/widgets/custom_button.dart';
import 'package:claim_app/core/widgets/custom_textfield.dart';
import 'package:claim_app/features/family/data/models/family_member_model.dart';
import 'package:claim_app/features/family/presentation/controllers/family_controller.dart';
import 'package:claim_app/features/family/presentation/controllers/family_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AddFamilyMemberScreen extends ConsumerStatefulWidget {
  const AddFamilyMemberScreen({super.key});

  @override
  ConsumerState<AddFamilyMemberScreen> createState() => _AddFamilyMemberScreenState();
}

class _AddFamilyMemberScreenState extends ConsumerState<AddFamilyMemberScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cnicController = TextEditingController();
  final _dobController = TextEditingController();

  RelationType _selectedRelation = RelationType.spouse;
  Gender _selectedGender = Gender.male;
  DateTime? _dateOfBirth;
  String? _attachmentPath;

  @override
  void dispose() {
    _nameController.dispose();
    _cnicController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final familyState = ref.watch(familyControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Family Member')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  validator: (value) => Validators.required(value, 'Name'),
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
                      child: Text(relation.displayName),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedRelation = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _cnicController,
                  label: 'CNIC Number',
                  validator: Validators.cnic,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<Gender>(
                  value: _selectedGender,
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                  ),
                  items: Gender.values.map((gender) {
                    return DropdownMenuItem<Gender>(
                      value: gender,
                      child: Text(gender.displayName),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedGender = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _dobController,
                  label: 'Date of Birth',
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  validator: (value) => Validators.required(value, 'Date of Birth'),
                ),
                const SizedBox(height: 16),
                _buildAttachmentSection(),
                const SizedBox(height: 24),
                familyState is FamilyLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                        text: 'Save Family Member',
                        onPressed: _saveFamilyMember,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAttachmentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Attachment (CNIC Copy)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Upload PDF or JPEG file (Max 2MB)',
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
        const SizedBox(height: 8),
        _attachmentPath == null
            ? CustomButton(
                text: 'Select File',
                onPressed: () => _pickAttachment(context),
                outlined: true,
              )
            : Row(
                children: [
                  Expanded(
                    child: Text(
                      _attachmentPath!.split('/').last,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _attachmentPath = null;
                      });
                    },
                  ),
                ],
              ),
      ],
    );
  }

  Future<void> _pickAttachment(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    
    // Show options for file selection
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select File Source'),
        content: const Text('Choose how you want to select the file'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            child: const Text('Gallery'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            child: const Text('Camera'),
          ),
        ],
      ),
    );

    if (source == null) return;

    try {
      final XFile? file = await picker.pickImage(
        source: source,
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
          _attachmentPath = file.path;
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error selecting file: ${e.toString()}')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateOfBirth = picked;
        _dobController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  Future<void> _saveFamilyMember() async {
    if (_formKey.currentState!.validate() && _dateOfBirth != null) {
      final member = FamilyMember(
        name: _nameController.text,
        relation: _selectedRelation,
        cnic: _cnicController.text,
        gender: _selectedGender,
        dateOfBirth: _dateOfBirth!,
        attachmentPath: _attachmentPath,
        createdAt: DateTime.now(),
      );

      try {
        await ref.read(familyControllerProvider.notifier).addMember(member);
        if (!mounted) return;
        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }
}