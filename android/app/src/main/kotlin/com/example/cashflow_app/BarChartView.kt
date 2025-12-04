package com.example.cashflow_app

import android.content.Context
import android.graphics.*
import android.util.AttributeSet
import android.view.View
import org.json.JSONArray
import kotlin.math.max

class BarChartView @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0
) : View(context, attrs, defStyleAttr) {

    private val barPaint = Paint(Paint.ANTI_ALIAS_FLAG)
    private val textPaint = Paint(Paint.ANTI_ALIAS_FLAG)
    private val gridPaint = Paint(Paint.ANTI_ALIAS_FLAG)
    
    private var chartData: List<ChartDataPoint> = emptyList()
    private var maxValue: Float = 100f
    
    init {
        barPaint.style = Paint.Style.FILL
        
        textPaint.color = Color.parseColor("#AAAAAA")
        textPaint.textSize = 24f
        textPaint.textAlign = Paint.Align.CENTER
        
        gridPaint.color = Color.parseColor("#22FFFFFF")
        gridPaint.strokeWidth = 1f
        gridPaint.style = Paint.Style.STROKE
    }
    
    fun setData(jsonData: String?, maxVal: Float) {
        try {
            if (jsonData.isNullOrEmpty()) {
                chartData = emptyList()
                maxValue = 100f
                invalidate()
                return
            }
            
            val jsonArray = JSONArray(jsonData)
            val dataPoints = mutableListOf<ChartDataPoint>()
            
            for (i in 0 until jsonArray.length()) {
                val item = jsonArray.getJSONObject(i)
                dataPoints.add(
                    ChartDataPoint(
                        label = item.getString("label"),
                        value = item.getDouble("value").toFloat()
                    )
                )
            }
            
            chartData = dataPoints
            maxValue = max(maxVal, 100f)
            invalidate()
        } catch (e: Exception) {
            e.printStackTrace()
            chartData = emptyList()
            invalidate()
        }
    }
    
    override fun onDraw(canvas: Canvas) {
        super.onDraw(canvas)
        
        if (chartData.isEmpty()) {
            return
        }
        
        val chartHeight = height - paddingTop - paddingBottom - 35f // Reserve less space for labels
        val chartWidth = width - paddingLeft - paddingRight
        val barWidth = (chartWidth / chartData.size) * 0.6f
        val barSpacing = (chartWidth / chartData.size) * 0.4f
        
        // Draw grid lines (fewer lines for smaller chart)
        for (i in 0..2) {
            val y = paddingTop + (chartHeight / 2f) * i
            canvas.drawLine(
                paddingLeft.toFloat(),
                y,
                (width - paddingRight).toFloat(),
                y,
                gridPaint
            )
        }
        
        // Draw bars and labels
        chartData.forEachIndexed { index, dataPoint ->
            val x = paddingLeft + (barWidth + barSpacing) * index + barSpacing / 2
            val barHeight = if (maxValue > 0) {
                (dataPoint.value / maxValue) * chartHeight
            } else {
                0f
            }
            val y = paddingTop + chartHeight - barHeight
            
            // Draw bar with gradient
            val gradient = LinearGradient(
                x, y,
                x, paddingTop + chartHeight,
                Color.parseColor("#F44336"),
                Color.parseColor("#E53935"),
                Shader.TileMode.CLAMP
            )
            barPaint.shader = gradient
            
            // Draw rounded rectangle bar
            val rect = RectF(x, y, x + barWidth, paddingTop + chartHeight)
            canvas.drawRoundRect(rect, 6f, 6f, barPaint)
            
            // Draw label with smaller text
            textPaint.textSize = 18f
            canvas.drawText(
                dataPoint.label,
                x + barWidth / 2,
                height - paddingBottom + 28f,
                textPaint
            )
        }
    }
    
    data class ChartDataPoint(
        val label: String,
        val value: Float
    )
}
