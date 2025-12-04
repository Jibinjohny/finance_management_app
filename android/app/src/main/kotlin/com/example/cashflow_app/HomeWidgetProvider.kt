package com.example.cashflow_app

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import android.content.Intent
import android.app.PendingIntent
import android.graphics.Bitmap
import android.graphics.Canvas
import es.antonborri.home_widget.HomeWidgetProvider

class HomeWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_layout)
            views.apply {
                val widgetData = widgetData ?: context.getSharedPreferences("HomeWidgetPreferences", Context.MODE_PRIVATE)
                
                // Get income and expense data
                val income = widgetData.getString("income", "₹0")
                val expense = widgetData.getString("expense", "₹0")
                
                android.util.Log.d("HomeWidget", "Income: $income, Expense: $expense")
                
                // Update TextViews
                setTextViewText(R.id.tv_income, income)
                setTextViewText(R.id.tv_expense, expense)
                
                // Set up Add Transaction button
                val addTransactionIntent = Intent(context, MainActivity::class.java).apply {
                    data = android.net.Uri.parse("cashflow://add_transaction")
                    flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
                }
                val addTransactionPendingIntent = PendingIntent.getActivity(
                    context,
                    widgetId + 1000,
                    addTransactionIntent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )
                setOnClickPendingIntent(R.id.btn_add_transaction, addTransactionPendingIntent)
                
                // Open app on widget click
                val intent = Intent(context, MainActivity::class.java).apply {
                    data = android.net.Uri.parse("cashflow://dashboard")
                    flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
                }
                val pendingIntent = PendingIntent.getActivity(
                    context,
                    widgetId,
                    intent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )
                setOnClickPendingIntent(R.id.widget_root, pendingIntent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
