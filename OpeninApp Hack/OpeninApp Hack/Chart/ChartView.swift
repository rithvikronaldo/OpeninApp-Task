import SwiftUI

struct LineChartView: View {
    let data: [Double]
    let title: String
    let legend: String
    let xAxisLabels: [String]
    let yAxisLabelCount: Int // Define the count of Y-axis labels
    let minY: Double // Minimum value of Y-axis data
    let maxY: Double // Maximum value of Y-axis data

    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    // Gradient below the line graph
                    LinearGradient(gradient: Gradient(colors: [.blue, .clear]), startPoint: .top, endPoint: .bottom)
                        .clipShape(
                            Path { path in
                                path.move(to: CGPoint(x: 0, y: geometry.size.height))
                                let yScaleFactor = geometry.size.height / CGFloat(maxY - minY)
                                for (index, value) in data.enumerated() {
                                    let x = geometry.size.width / CGFloat(data.count - 1) * CGFloat(index)
                                    let y = geometry.size.height - CGFloat(value - minY) * yScaleFactor
                                    path.addLine(to: CGPoint(x: x, y: y))
                                }
                                path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                                path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                            }
                        )
                    // Solid line graph
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: geometry.size.height))
                        let yScaleFactor = geometry.size.height / CGFloat(maxY - minY)
                        for (index, value) in data.enumerated() {
                            let x = geometry.size.width / CGFloat(data.count - 1) * CGFloat(index)
                            let y = geometry.size.height - CGFloat(value - minY) * yScaleFactor
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))

                    // Horizontal gridlines
                    // Horizontal gridlines
                    ForEach(0..<yAxisLabelCount, id: \.self) { index in
                        let yValue = maxY - ((maxY - minY) / Double(yAxisLabelCount - 1)) * Double(index)
                        let yPosition = geometry.size.height - CGFloat(yValue - minY) * (geometry.size.height / CGFloat(maxY - minY))
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: yPosition))
                            path.addLine(to: CGPoint(x: geometry.size.width, y: yPosition))
                        }
                        .stroke(Color.gray.opacity(0.5), style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                    }


                    // Vertical gridlines
                    ForEach(0..<xAxisLabels.count - 1, id: \.self) { index in
                        let x = geometry.size.width / CGFloat(xAxisLabels.count - 1) * CGFloat(index)
                        Path { path in
                            path.move(to: CGPoint(x: x, y: 0))
                            path.addLine(to: CGPoint(x: x, y: geometry.size.height))
                        }
                        .stroke(Color.gray.opacity(0.5), style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                    }


                    // X-axis labels
                    HStack(spacing: -44) { // Reduced spacing between labels
                        ForEach(xAxisLabels.indices, id: \.self) { index in
                            Text(xAxisLabels[index])
                                .font(.system(size: 6.5, weight: .bold)) // Increased font size and set to bold
                                .foregroundColor(Color.gray) // Set text color to gray
                                .rotationEffect(Angle(degrees: -90))
                                .frame(width: 55, height: 20, alignment: .center)
                                .offset(x: -23, y: 5)
                        }
                    }
                    .padding(.top, geometry.size.height)
                    
                    // Y-axis labels
                    VStack(spacing: -11) {
                        ForEach((0...yAxisLabelCount).reversed(), id: \.self) { labelIndex in
                            let yValue = maxY - ((maxY - minY) / Double(yAxisLabelCount)) * Double(labelIndex)
                            let yPosition = geometry.size.height - CGFloat(yValue - minY) * (geometry.size.height / CGFloat(maxY - minY))
                            Text(String(labelIndex))
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(Color.gray)
                                .frame(width: 40, height: 10, alignment: .trailing)
                                .offset(x: -200, y: -yPosition + 90)
                        }
                    }
                    .padding(.leading, 5)
                }
            }
            .frame(height: 200)
            .padding()
        }
    }
}

struct ChartView: View {
    @ObservedObject var viewModel: ChartViewModel
    
    let chartWidth: CGFloat = 300 // Set the width of the chart
    let chartHeight: CGFloat = 200 // Set the height of the chart
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 0.2)
                .frame(width: 360, height: 300) // Set the frame of the rounded rectangle
            
            VStack {
                HStack {
                    Text("Overview")
                        .font(.system(size: 15, weight: .thin)) // Adjust size and weight as needed
                        .padding(.top, 5)
                        .padding(.trailing, 110)
                        .foregroundColor(.gray)// Add leading padding
                    
                   
                    
                    Button(action: {
                        // Action for the button
                    }) {
                        HStack {
                            Text("10 Apr - 15 Apr")
                                .font(.caption)
                                .foregroundColor(.black)// Adjust text size
                            Image(systemName: "clock")
                                .font(.caption) // Adjust image size
                        }
                        .padding(5)
                        .foregroundColor(.gray)
                        .background(Color.white)
                        .border(Color.gray, width: 1) // Add light gray border
                        .cornerRadius(3)
                    }
                    .frame(width: 120, height: 20) // Adjust button width and height
                }
                .padding(.horizontal)
                .padding(.vertical)// Add horizontal padding
                
                if !viewModel.chartData.isEmpty {
                    LineChartView(data: viewModel.chartData.map { Double($0.1) },
                                  title: "Chart Title",
                                  legend: "Chart Legend",
                                  xAxisLabels: viewModel.xAxisLabels,
                                  yAxisLabelCount: viewModel.yAxisLabelCount,
                                  minY: viewModel.minY,
                                  maxY: viewModel.maxY) // Pass minY and maxY
                        .frame(width: chartWidth+10, height: chartHeight) // Set the frame of the LineChartView
                        .padding(.top,0)
                        .padding(.bottom,30)
                } else {
                    Text("No data available")
                }
            }
            .onAppear {
                print("X Axis Labels: \(viewModel.xAxisLabels)")
            }
        }
    }
}
