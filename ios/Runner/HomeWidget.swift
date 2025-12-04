import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(
            date: Date(),
            chartData: [],
            maxValue: 100,
            viewMode: "daily",
            todayExpense: "₹0",
            monthExpense: "₹0"
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let data = UserDefaults.init(suiteName: "group.com.example.cashflow_app")
        let entry = createEntry(from: data)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getSnapshot(in: context) { (entry) in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
    
    private func createEntry(from data: UserDefaults?) -> SimpleEntry {
        let viewMode = data?.string(forKey: "view_mode") ?? "daily"
        let isDaily = viewMode == "daily"
        
        let chartDataString = isDaily
            ? data?.string(forKey: "chart_data_daily")
            : data?.string(forKey: "chart_data_monthly")
        
        let maxValue = isDaily
            ? data?.double(forKey: "max_value_daily") ?? 100
            : data?.double(forKey: "max_value_monthly") ?? 100
        
        let todayExpense = data?.string(forKey: "total_expense_today") ?? "₹0"
        let monthExpense = data?.string(forKey: "total_expense_month") ?? "₹0"
        
        var chartData: [ChartDataPoint] = []
        if let jsonString = chartDataString,
           let jsonData = jsonString.data(using: .utf8) {
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: jsonData) as? [[String: Any]] {
                    chartData = jsonArray.compactMap { item in
                        guard let label = item["label"] as? String,
                              let value = item["value"] as? Double else {
                            return nil
                        }
                        return ChartDataPoint(label: label, value: value)
                    }
                }
            } catch {
                print("Error parsing chart data: \(error)")
            }
        }
        
        return SimpleEntry(
            date: Date(),
            chartData: chartData,
            maxValue: maxValue,
            viewMode: viewMode,
            todayExpense: todayExpense,
            monthExpense: monthExpense
        )
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let chartData: [ChartDataPoint]
    let maxValue: Double
    let viewMode: String
    let todayExpense: String
    let monthExpense: String
}

struct ChartDataPoint {
    let label: String
    let value: Double
}

struct HomeWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            // Gradient Background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.16, green: 0.16, blue: 0.24),
                    Color(red: 0.12, green: 0.12, blue: 0.19),
                    Color(red: 0.10, green: 0.10, blue: 0.18)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            VStack(alignment: .leading, spacing: 12) {
                // Header with Toggle
                HStack {
                    HStack(spacing: 6) {
                        Image(systemName: "chart.bar.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                        Text("CashFlow Expenses")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    // Toggle Buttons
                    HStack(spacing: 4) {
                        ToggleButton(
                            text: "Daily",
                            isSelected: entry.viewMode == "daily"
                        )
                        ToggleButton(
                            text: "Monthly",
                            isSelected: entry.viewMode == "monthly"
                        )
                    }
                    .padding(3)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                }
                
                // Bar Chart
                if entry.chartData.isEmpty {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("No expense data")
                            .font(.system(size: 11))
                            .foregroundColor(.white.opacity(0.4))
                        Spacer()
                    }
                    Spacer()
                } else {
                    BarChartView(
                        data: entry.chartData,
                        maxValue: entry.maxValue
                    )
                    .frame(height: 100)
                }
                
                // Summary Section
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(entry.viewMode == "daily" ? "Today's Expense" : "This Month")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                        Text(entry.viewMode == "daily" ? entry.todayExpense : entry.monthExpense)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color(red: 0.96, green: 0.26, blue: 0.21))
                    }
                    
                    Spacer()
                    
                    Image(systemName: "dollarsign.circle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.white.opacity(0.2))
                }
            }
            .padding(16)
        }
    }
}

struct ToggleButton: View {
    let text: String
    let isSelected: Bool
    
    var body: some View {
        Text(text)
            .font(.system(size: 10, weight: isSelected ? .bold : .regular))
            .foregroundColor(isSelected ? .white : .white.opacity(0.6))
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                isSelected
                    ? LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.42, green: 0.36, blue: 0.91),
                            Color(red: 0.36, green: 0.30, blue: 0.78)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    : LinearGradient(
                        gradient: Gradient(colors: [Color.clear, Color.clear]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
            )
            .cornerRadius(8)
    }
}

struct BarChartView: View {
    let data: [ChartDataPoint]
    let maxValue: Double
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom, spacing: 0) {
                ForEach(data.indices, id: \.self) { index in
                    VStack(spacing: 4) {
                        Spacer()
                        
                        // Bar
                        let barHeight = maxValue > 0
                            ? CGFloat(data[index].value / maxValue) * (geometry.size.height - 30)
                            : 0
                        
                        RoundedRectangle(cornerRadius: 4)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(red: 0.96, green: 0.26, blue: 0.21),
                                        Color(red: 0.90, green: 0.22, blue: 0.21)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(
                                width: (geometry.size.width / CGFloat(data.count)) * 0.6,
                                height: max(barHeight, 2)
                            )
                        
                        // Label
                        Text(data[index].label)
                            .font(.system(size: 8))
                            .foregroundColor(.white.opacity(0.6))
                            .frame(height: 20)
                    }
                    .frame(width: geometry.size.width / CGFloat(data.count))
                }
            }
        }
    }
}

@main
struct HomeWidget: Widget {
    let kind: String = "HomeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            HomeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("CashFlow Expenses")
        .description("View your expense trends with interactive charts.")
        .supportedFamilies([.systemMedium])
    }
}

