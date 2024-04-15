import SwiftUI

struct OverviewComponent: View {
    @StateObject var chartViewModel = ChartViewModel()
    
    let currentDate: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        return dateFormatter.string(from: Date())
    }()

    var body: some View {
        ZStack {
            // Light gray background for the entire ZStack
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 350, height: 320)
                .padding()
            
            VStack(alignment: .center) {
                HStack {
                    Text("Overview")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .padding(.trailing, 100)
                    
                    // Use padding instead of Spacer
                    // Adjust the amount of padding as needed
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .frame(width: 80, height: 30)
                        .overlay(
                            Text(currentDate)
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1) // Add gray border
                        )
                }
                .padding(.top, -200)
                .padding(.leading, -20) // Add padding here
                
                ChartView(viewModel: chartViewModel)
                    .padding(.top, -10)
                    .padding(.leading, -20) // Adjust the padding here to match the outer padding
            }
            .padding() // Add padding here to ensure uniform padding around the VStack
        }
    }
}
