import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/transaction.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:intl/intl.dart';

class PdfService {
  // Helper function to load image from assets
  Future<pw.ImageProvider> imageFromAssetBundle(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    return pw.MemoryImage(data.buffer.asUint8List());
  }

  Future<Uint8List> generateMonthlyReport({
    required String monthYear,
    required double totalIncome,
    required double totalExpense,
    required List<Transaction> transactions,
    required Map<String, double> categoryExpenses,
    required String currencySymbol,
    required Map<String, String> accountNames,
    required Map<String, String> localizedLabels,
  }) async {
    final pdf = pw.Document();
    final appIconImage = await imageFromAssetBundle('assets/icon/app_icon.png');

    // Load fonts
    final font = await PdfGoogleFonts.interRegular();
    final boldFont = await PdfGoogleFonts.interBold();

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          margin: const pw.EdgeInsets.all(32),
          theme: pw.ThemeData.withFont(base: font, bold: boldFont),
        ),
        build: (context) => [
          _buildHeader(
            monthYear,
            font,
            boldFont,
            appIconImage,
            localizedLabels,
          ),
          pw.SizedBox(height: 20),
          _buildSummaryCards(
            totalIncome,
            totalExpense,
            currencySymbol,
            localizedLabels,
          ),
          pw.SizedBox(height: 20),
          _buildCategoryBreakdown(
            categoryExpenses,
            totalExpense,
            currencySymbol,
            localizedLabels,
          ),
          pw.SizedBox(height: 20),
          _buildTransactionTable(
            transactions,
            font,
            boldFont,
            currencySymbol,
            accountNames,
            localizedLabels,
          ),
        ],
      ),
    );

    return pdf.save();
  }

  Future<void> shareMonthlyReport({
    required String monthYear,
    required double totalIncome,
    required double totalExpense,
    required List<Transaction> transactions,
    required Map<String, double> categoryExpenses,
    required String currencySymbol,
    required Map<String, String> accountNames,
    required Map<String, String> localizedLabels,
  }) async {
    final pdfBytes = await generateMonthlyReport(
      monthYear: monthYear,
      totalIncome: totalIncome,
      totalExpense: totalExpense,
      transactions: transactions,
      categoryExpenses: categoryExpenses,
      currencySymbol: currencySymbol,
      accountNames: accountNames,
      localizedLabels: localizedLabels,
    );

    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: 'CashFlow_Report_${monthYear.replaceAll(' ', '_')}.pdf',
    );
  }

  pw.Widget _buildHeader(
    String monthYear,
    pw.Font font,
    pw.Font boldFont,
    pw.ImageProvider appIconImage,
    Map<String, String> localizedLabels,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                children: [
                  // App Icon
                  pw.Container(
                    width: 40,
                    height: 40,
                    child: pw.Image(appIconImage),
                  ),
                  pw.SizedBox(width: 10),
                  // App Name
                  pw.Text(
                    'CashFlow',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.deepPurple,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                localizedLabels['monthlyFinancialReport'] ??
                    'Monthly Financial Report',
                style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700),
              ),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                monthYear,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.black,
                ),
              ),
              pw.Text(
                (localizedLabels['generatedOn'] ?? 'Generated on {date}')
                    .replaceAll(
                      '{date}',
                      DateFormat('dd MMM yyyy').format(DateTime.now()),
                    ),
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.grey600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildSummaryCards(
    double income,
    double expense,
    String currencySymbol,
    Map<String, String> localizedLabels,
  ) {
    final netBalance = income - expense;
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        _buildSummaryCard(
          localizedLabels['income'] ?? 'Income',
          income,
          PdfColor.fromHex('#81C784'),
          PdfColors.green50,
          currencySymbol,
        ),
        pw.SizedBox(width: 10),
        _buildSummaryCard(
          localizedLabels['expense'] ?? 'Expense',
          expense,
          PdfColor.fromHex('#E57373'),
          PdfColors.red50,
          currencySymbol,
        ),
        pw.SizedBox(width: 10),
        _buildSummaryCard(
          localizedLabels['netBalance'] ?? 'Net Balance',
          netBalance,
          netBalance >= 0 ? PdfColors.blue : PdfColors.orange,
          netBalance >= 0 ? PdfColors.blue50 : PdfColors.orange50,
          currencySymbol,
        ),
      ],
    );
  }

  pw.Widget _buildSummaryCard(
    String title,
    double amount,
    PdfColor color,
    PdfColor bgColor,
    String currencySymbol,
  ) {
    return pw.Expanded(
      child: pw.Container(
        padding: const pw.EdgeInsets.all(12),
        decoration: pw.BoxDecoration(
          color: bgColor,
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
          border: pw.Border.all(color: color, width: 1),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              title,
              style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              '$currencySymbol${amount.toStringAsFixed(2)}',
              style: pw.TextStyle(
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  pw.Widget _buildCategoryBreakdown(
    Map<String, double> categoryExpenses,
    double totalExpense,
    String currencySymbol,
    Map<String, String> localizedLabels,
  ) {
    if (categoryExpenses.isEmpty) return pw.Container();

    // Sort categories by amount descending
    final sortedEntries = categoryExpenses.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            localizedLabels['expenseBreakdown'] ?? 'Expense Breakdown',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 10),
          ...sortedEntries.map((entry) {
            final percentage = totalExpense > 0
                ? (entry.value / totalExpense) * 100
                : 0.0;
            return pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 8),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      entry.key,
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                  ),
                  pw.Expanded(
                    flex: 5,
                    child: pw.Stack(
                      alignment: pw.Alignment.centerLeft,
                      children: [
                        pw.Container(
                          height: 8,
                          decoration: pw.BoxDecoration(
                            color: PdfColors.grey200,
                            borderRadius: const pw.BorderRadius.all(
                              pw.Radius.circular(4),
                            ),
                          ),
                        ),
                        pw.Container(
                          height: 8,
                          width: 200 * (percentage / 100),
                          decoration: pw.BoxDecoration(
                            color: PdfColors.blue,
                            borderRadius: const pw.BorderRadius.all(
                              pw.Radius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      '${percentage.toStringAsFixed(1)}%',
                      textAlign: pw.TextAlign.right,
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      '$currencySymbol${entry.value.toStringAsFixed(2)}',
                      textAlign: pw.TextAlign.right,
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  pw.Widget _buildTransactionTable(
    List<Transaction> transactions,
    pw.Font font,
    pw.Font boldFont,
    String currencySymbol,
    Map<String, String> accountNames,
    Map<String, String> localizedLabels,
  ) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300),
      columnWidths: {
        0: const pw.FlexColumnWidth(2), // Date
        1: const pw.FlexColumnWidth(3), // Category
        2: const pw.FlexColumnWidth(3), // Account
        3: const pw.FlexColumnWidth(2), // Payment
        4: const pw.FlexColumnWidth(3), // Description
        5: const pw.FlexColumnWidth(2), // Amount
      },
      children: [
        // Header Row
        pw.TableRow(
          decoration: pw.BoxDecoration(color: PdfColor.fromHex('#6B5CE7')),
          children: [
            _buildTableHeader(localizedLabels['dateHeader'] ?? 'Date'),
            _buildTableHeader(localizedLabels['categoryLabel'] ?? 'Category'),
            _buildTableHeader(localizedLabels['accountBreakdown'] ?? 'Account'),
            _buildTableHeader(localizedLabels['modeHeader'] ?? 'Mode'),
            _buildTableHeader(
              localizedLabels['descriptionHeader'] ?? 'Description',
            ),
            _buildTableHeader(localizedLabels['amountHeader'] ?? 'Amount'),
          ],
        ),
        // Data Rows
        ...transactions.map((tx) {
          final isExpense = tx.isExpense;
          final accountName = tx.accountId != null
              ? (accountNames[tx.accountId] ?? 'Unknown')
              : '-';

          return pw.TableRow(
            children: [
              _buildTableCell(DateFormat('dd/MM/yy').format(tx.date)),
              _buildTableCell(tx.category),
              _buildTableCell(accountName),
              _buildTableCell(tx.paymentMode),
              _buildTableCell(tx.title),
              _buildTableCell(
                '${isExpense ? "-" : "+"}$currencySymbol${tx.amount.toStringAsFixed(2)}',
                textColor: isExpense
                    ? PdfColor.fromHex('#E57373')
                    : PdfColor.fromHex('#81C784'),
                isBold: true,
                align: pw.TextAlign.right,
              ),
            ],
          );
        }),
      ],
    );
  }

  pw.Widget _buildTableHeader(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          color: PdfColors.white,
          fontWeight: pw.FontWeight.bold,
          fontSize: 10,
        ),
        textAlign: pw.TextAlign.center,
      ),
    );
  }

  pw.Widget _buildTableCell(
    String text, {
    PdfColor textColor = PdfColors.black,
    bool isBold = false,
    pw.TextAlign align = pw.TextAlign.left,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          color: textColor,
          fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
          fontSize: 9,
        ),
        textAlign: align,
      ),
    );
  }
}
