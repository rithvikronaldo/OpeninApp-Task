import Foundation
import Combine

class ChartViewModel: ObservableObject {
    @Published var chartData: [(String, Int)] = []
    @Published var xAxisLabels: [String] = []
    let yAxisLabelCount: Int = 4 // Define the count of Y-axis labels
    var minY: Double = 0 // Minimum value of Y-axis data
    var maxY: Double = 0 // Maximum value of Y-axis data

    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Subscribe to changes in overall_url_chart from ContentViewModel
        ContentViewModel.shared.$overall_url_chart
            .map { $0.sorted(by: { $0.key < $1.key }) }
            .map { $0.map { ($0.key, $0.value) } }
            .sink(receiveValue: { [weak self] data in
                self?.chartData = data
                self?.xAxisLabels = data.map { $0.0 }
                    .map { time in
                        let formatter = DateFormatter()
                        formatter.dateFormat = "HH:mm"
                        guard let date = formatter.date(from: time) else { return time }
                        formatter.dateFormat = "HH:mm"
                        return formatter.string(from: date)
                    }
                
                // Calculate minY and maxY
                if let minData = data.map({ Double($0.1) }).min(), let maxData = data.map({ Double($0.1) }).max() {
                    self?.minY = minData
                    self?.maxY = maxData
                }
                
                print("X Axis Labels: \(self?.xAxisLabels ?? [])") // Print xAxisLabels
            })
            .store(in: &cancellables)
    }
}


