import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'database_helper.dart';
import '../widgets/glass_dialog.dart';

class BackupService {
  static final BackupService _instance = BackupService._internal();
  factory BackupService() => _instance;
  BackupService._internal();

  Future<String> _getDbPath() async {
    final dbPath = await getDatabasesPath();
    return join(dbPath, 'cashflow_v4.db');
  }

  Future<void> exportDatabase(BuildContext context) async {
    try {
      final dbPath = await _getDbPath();
      final file = File(dbPath);

      if (!await file.exists()) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Database file not found')),
          );
        }
        return;
      }

      final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final fileName = 'cashflow_backup_$timestamp.db';

      // Create a temporary copy to share
      final tempDir = Directory.systemTemp;
      final tempPath = join(tempDir.path, fileName);
      await file.copy(tempPath);

      final xFile = XFile(tempPath);

      await Share.shareXFiles([xFile], text: 'CashFlow App Backup');
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Export failed: $e')));
      }
    }
  }

  Future<bool> importDatabase(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType
            .any, // .db files might not have a specific mime type mapped everywhere
      );

      if (result == null || result.files.single.path == null) {
        return false; // User canceled
      }

      final pickedPath = result.files.single.path!;
      final pickedFile = File(pickedPath);

      // Basic validation: check if file is not empty
      if (await pickedFile.length() == 0) {
        throw Exception('Selected file is empty');
      }

      // Confirm with user
      if (!context.mounted) return false;
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => GlassDialog(
          title: 'Restore Backup',
          content: const Text(
            'This will overwrite your current data with the selected backup. This action cannot be undone. Are you sure?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Restore', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );

      if (confirmed != true) return false;

      // Close current DB connection
      await DatabaseHelper.instance.close();

      final dbPath = await _getDbPath();

      // Backup current DB just in case (optional, but good practice)
      // final backupPath = '$dbPath.bak';
      // final currentFile = File(dbPath);
      // if (await currentFile.exists()) {
      //   await currentFile.copy(backupPath);
      // }

      // Overwrite DB
      await pickedFile.copy(dbPath);

      // Re-initialize DB (this happens automatically on next access via DatabaseHelper.instance.database)
      // But we might need to trigger a reload of providers.

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Restore successful. Please restart the app to see changes.',
            ),
          ),
        );
      }

      return true;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Import failed: $e')));
      }
      return false;
    }
  }
}
