// features/family/presentation/screens/family_member_list_screen.dart
import 'package:claim_app/features/family/data/repositories/family_repository.dart';
import 'package:claim_app/features/family/presentation/controllers/family_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:claim_app/features/family/data/models/family_member_model.dart';
import 'package:claim_app/navigation/route_names.dart';
import 'package:go_router/go_router.dart';

class FamilyMemberListScreen extends ConsumerStatefulWidget {
  const FamilyMemberListScreen({super.key});

  @override
  ConsumerState<FamilyMemberListScreen> createState() =>
      _FamilyMemberListScreenState();
}

class _FamilyMemberListScreenState
    extends ConsumerState<FamilyMemberListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(familyControllerProvider.notifier).loadFamilyMembers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final familyState = ref.watch(familyControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Members'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.pushNamed(RouteNames.addFamilyMember),
          ),
        ],
      ),
      body: familyState is FamilyLoading
          ? const Center(child: CircularProgressIndicator())
          : familyState is FamilyError
              ? Center(child: Text(familyState.message))
              : familyState is FamilyLoaded
                  ? _buildFamilyMemberTable(familyState.members)
                  : const SizedBox(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(RouteNames.addFamilyMember),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFamilyMemberTable(List<FamilyMember> members) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Relation')),
          DataColumn(label: Text('CNIC')),
          DataColumn(label: Text('Age')),
          DataColumn(label: Text('Gender')),
          DataColumn(label: Text('Attachment')), // New column for attachment
        ],
        rows: members.map((member) {
          final age = DateTime.now().year - member.dateOfBirth.year;
          return DataRow(
            cells: [
              DataCell(Text(member.name)),
              DataCell(Text(member.relation.displayName)),
              DataCell(Text(member.cnic)),
              DataCell(Text(age.toString())),
              DataCell(Text(member.gender.displayName)),
              DataCell(_buildAttachmentIcon(member)), // Attachment icon cell
            ],
            onSelectChanged: (_) => _showMemberDetails(context, member),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAttachmentIcon(FamilyMember member) {
    if (member.attachmentPath == null) {
      return const Icon(Icons.no_accounts, color: Colors.grey);
    }

    final extension = member.attachmentPath!.split('.').last.toLowerCase();

    if (extension == 'pdf') {
      return const Icon(Icons.picture_as_pdf, color: Colors.red);
    } else if (['jpg', 'jpeg', 'png', 'gif'].contains(extension)) {
      return const Icon(Icons.image, color: Colors.blue);
    } else {
      return const Icon(Icons.attach_file, color: Colors.green);
    }
  }

  void _showMemberDetails(BuildContext context, FamilyMember member) {
    final age = DateTime.now().year - member.dateOfBirth.year;
    final dobFormatted =
        '${member.dateOfBirth.day}/${member.dateOfBirth.month}/${member.dateOfBirth.year}';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(member.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Relation: ${member.relation.displayName}'),
              Text('CNIC: ${member.cnic}'),
              Text('Gender: ${member.gender.displayName}'),
              Text('Date of Birth: $dobFormatted'),
              Text('Age: $age years'),
              Text('Added on: ${member.createdAt.toLocal()}'),
              const SizedBox(height: 16),
              _buildAttachmentSection(member), // Show attachment in details
            ],
          ),
        ),
        actions: [
          if (member.attachmentPath != null)
            TextButton(
              onPressed: () => _viewAttachment(context, member),
              child: const Text('View Attachment'),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentSection(FamilyMember member) {
    if (member.attachmentPath == null) {
      return const SizedBox();
    }

    final extension = member.attachmentPath!.split('.').last.toLowerCase();
    final isPdf = extension == 'pdf';
    final isImage = ['jpg', 'jpeg', 'png', 'gif'].contains(extension);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Attachment:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            isPdf
                ? const Icon(Icons.picture_as_pdf, color: Colors.red, size: 24)
                : isImage
                    ? const Icon(Icons.image, color: Colors.blue, size: 24)
                    : const Icon(Icons.attach_file,
                        color: Colors.green, size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                member.attachmentPath!.split('/').last,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _viewAttachment(BuildContext context, FamilyMember member) {
    // For now, just show a dialog with file info
    // In a real app, you would open the file using a PDF viewer or image viewer
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Attachment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('File: ${member.attachmentPath!.split('/').last}'),
            Text(
                'Type: ${member.attachmentPath!.split('.').last.toUpperCase()}'),
            const SizedBox(height: 16),
            const Text(
              'In a real application, this would open the PDF/image viewer.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
