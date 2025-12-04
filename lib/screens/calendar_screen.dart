import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../providers/transaction_provider.dart';
import '../models/transaction.dart';
import '../utils/app_colors.dart';
import '../utils/currency_helper.dart';
import '../widgets/glass_container.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;

    // Listen to scroll events to auto-shrink calendar
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        // If scrolled down more than 50 pixels, shrink to week view
        if (_scrollController.offset > 50 &&
            _calendarFormat == CalendarFormat.month) {
          setState(() {
            _calendarFormat = CalendarFormat.week;
          });
        }
        // If scrolled back to top, expand to month view
        else if (_scrollController.offset <= 10 &&
            _calendarFormat == CalendarFormat.week) {
          setState(() {
            _calendarFormat = CalendarFormat.month;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<Transaction> _getEventsForDay(
    DateTime day,
    List<Transaction> allTransactions,
  ) {
    return allTransactions.where((t) {
      return t.date.year == day.year &&
          t.date.month == day.month &&
          t.date.day == day.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Calendar',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1A1A2E),
                  Color(0xFF16213E),
                  Color(0xFF0F3460),
                  Color(0xFF1A1A2E),
                  Color(0xFF16213E),
                ],
              ),
            ),
          ),
          // Blobs
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withValues(alpha: 0.2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.2),
                    blurRadius: 80,
                    spreadRadius: 40,
                  ),
                ],
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Consumer<TransactionProvider>(
              builder: (context, provider, child) {
                final transactions = provider.transactions;
                final selectedTransactions = _getEventsForDay(
                  _selectedDay!,
                  transactions,
                );

                return Column(
                  children: [
                    GlassContainer(
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.only(bottom: 8),
                      child: TableCalendar(
                        firstDay: DateTime.utc(2020, 1, 1),
                        lastDay: DateTime.utc(2030, 12, 31),
                        focusedDay: _focusedDay,
                        calendarFormat: _calendarFormat,
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          if (!isSameDay(_selectedDay, selectedDay)) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });
                          }
                        },
                        onFormatChanged: (format) {
                          if (_calendarFormat != format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          }
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                        eventLoader: (day) =>
                            _getEventsForDay(day, transactions),
                        calendarStyle: CalendarStyle(
                          defaultTextStyle: TextStyle(color: Colors.white),
                          weekendTextStyle: TextStyle(color: Colors.white70),
                          outsideTextStyle: TextStyle(color: Colors.white24),
                          selectedDecoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          todayDecoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                          ),
                          markerDecoration: BoxDecoration(
                            color: AppColors.secondary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          leftChevronIcon: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                          ),
                          rightChevronIcon: Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: selectedTransactions.length,
                        itemBuilder: (context, index) {
                          final transaction = selectedTransactions[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 12),
                            child: GlassContainer(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: transaction.isExpense
                                          ? AppColors.expense.withValues(
                                              alpha: 0.2,
                                            )
                                          : AppColors.income.withValues(
                                              alpha: 0.2,
                                            ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      transaction.isExpense
                                          ? Icons.arrow_downward
                                          : Icons.arrow_upward,
                                      color: transaction.isExpense
                                          ? AppColors.expense
                                          : AppColors.income,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          transaction.title,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          transaction.category,
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${transaction.isExpense ? '-' : '+'}${CurrencyHelper.getSymbol(context)}${transaction.amount.toStringAsFixed(0)}',
                                    style: TextStyle(
                                      color: transaction.isExpense
                                          ? AppColors.expense
                                          : AppColors.income,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
