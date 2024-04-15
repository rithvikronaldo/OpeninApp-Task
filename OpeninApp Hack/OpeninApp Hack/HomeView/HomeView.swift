import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = ContentViewModel.shared
    @StateObject var chartViewModel = ChartViewModel()
    @State private var showRecentLinks = true // State to track which links to show

    // Define sample data for DataViewItem
    let totalLinksItem = DataViewItem(title: "Total Links", detail: "100", imageName: "mark")
    let todayClicksItem = DataViewItem(title: "Today Clicks", detail: "50", imageName: "click")
    let topSourceItem = DataViewItem(title: "Top Source", detail: "Website", imageName: "globe")
    let topLocationItem = DataViewItem(title: "Top Location", detail: "United States", imageName: "mark")

    var body: some View {
        ZStack {
            Color(red: 14/255, green: 111/255, blue: 255/255)
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                Text("Dashboard")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.trailing, 180)
                    .padding(.leading, -10)
                    .fontWeight(.bold)

                
                        
                        Button(action: {
                            // Action for the square button
                        }) {
                            Image("settings")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                                .padding(8)
                        }
                    }
            .offset(x:5,y:-290)

            ScrollView {
                VStack {
                    Spacer()
                        .frame(height: 50) // Add space to reveal the background color

                    VStack(alignment: .leading) { // Align elements to the top left
                        Text(getGreeting())
                            .foregroundColor(.gray)
                            .font(.system(size: 18))
                        Text("Rithvik Ronaldo 👋")
                            .foregroundColor(.black)
                            .font(.system(size: 24, weight: .bold)) // Use system font with bold style
                            .padding(.top, -10)

 // Adjust top padding
                        ChartView(viewModel: chartViewModel)
                            .padding(.top, 2)
                        
                    }


                    DataView(totalLinksItem: totalLinksItem, todayClicksItem: todayClicksItem, topSourceItem: topSourceItem, topLocationItem: topLocationItem)
                        .padding(.top, 5)
                        .padding(.bottom,5)// Add top padding to the DataView
                    
                    
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(Color.gray, lineWidth: 1) // Adjust the width of the border
                        .frame(width: 350, height: 50) // Adjust the width and height of the border
                        .overlay(
                            HStack {
                                Button(action: {
                                    // Action for the button
                                }) {
                                    Image("graph")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.white)
                                        .padding(8)
                                }
                                .cornerRadius(10)

                                Text("View Analytics")
                                    .foregroundColor(.black)
                                    .font(.headline)
                            }
                                .padding(.top,5)
                                .padding(.bottom,10)// Padding around the HStack
                        )



                    
                   

                    HStack {
                        Button("Recent Links") {
                            showRecentLinks = true
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8) // Reduce vertical padding
                        .background(showRecentLinks ? Color.blue : Color.clear)
                        .foregroundColor(showRecentLinks ? Color.white : Color.gray)
                        .cornerRadius(15) // Adjust corner radius

                        Button("Top Links") {
                            showRecentLinks = false
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8) // Reduce vertical padding
                        .background(showRecentLinks ? Color.clear : Color.blue)
                        .foregroundColor(showRecentLinks ? Color.gray : Color.white)
                        .cornerRadius(15)
                        .padding(.trailing,30)// Adjust corner radius



                        Button {
                            // Action for the new square button
                        } label: {
                            Image("scope")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(8) // Adjust padding to make it square
                                .frame(width: 35, height: 35) // Ensure it's a square
                                .background(Color.clear)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10)) // Rounded rectangle shape
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1) // Gray border
                                )
                        }
                        .padding(.vertical, 8) // Add vertical padding
                        .buttonStyle(PlainButtonStyle()) // Remove button style
                    }
                    .padding(.top,20)
                    .padding(.bottom,-30)
                    

                    // Show RecentLinksListView or TopLinksListView based on the value of showRecentLinks
                    VStack {
                        if showRecentLinks {
                            RecentLinksListView(links: viewModel.recentLinks)
                        } else {
                            TopLinksListView(links: viewModel.topLinks)
                        }
                        
                        Spacer()
                            .frame(height: 40)
                        
                        VStack {
                            RoundedRectangle(cornerRadius: 15)
                                .strokeBorder(Color.gray, lineWidth: 1) // Adjust the width of the border
                                .frame(width: 350, height: 50) // Adjust the width and height of the border
                                .overlay(
                                    HStack {
                                        Button(action: {
                                            // Action for the button
                                        }) {
                                            Image("Links")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(.white)
                                                .padding(8)
                                        }
                                        .cornerRadius(10)
                                        
                                        Text("View all Links")
                                            .foregroundColor(.black)
                                            .font(.headline)
                                    }
                                        .padding(.top, 5)
                                        .padding(.bottom, 10) // Padding around the HStack
                                )
                            
                            Spacer()
                                .frame(height: 40) // Adjust height of spacer for more space between buttons
                            
                            RoundedRectangle(cornerRadius: 15)
                                .strokeBorder(Color(hex: "4AD15F"), lineWidth: 1) // Adjust the width of the border
                                .frame(width: 350, height: 50)
                                .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color(hex: "4AD15F").opacity(0.2)) // Set the fill color inside the border
                                    )// Adjust the width and height of the border
                                .overlay(
                                    HStack {
                                        Button(action: {
                                            // Action for the button
                                        }) {
                                            Image("whatsapp")
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                                .foregroundColor(.white)
                                                .padding(8)
                                        }
                                        .cornerRadius(10)
                                        
                                        Text("Talk with us")
                                            .foregroundColor(.black)
                                            .font(.system(size: 15))
                                            .bold()
                                    }
                                        .padding(.top, 5)
                                        .padding(.bottom, 10)
                                        .padding(.trailing,185)// Padding around the HStack
                                )
                            
                            
                            RoundedRectangle(cornerRadius: 15)
                                .strokeBorder(Color(hex: "E8F1FF"), lineWidth: 4) // Adjust the width of the border
                                .frame(width: 350, height: 50)
                                .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color(hex: "E8F1FF").opacity(0.5)) // Set the fill color inside the border
                                    )// Adjust the width and height of the border// Adjust the width and height of the border
                                .overlay(
                                    HStack {
                                        Button(action: {
                                            // Action for the button
                                        }) {
                                            Image("question")
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                                .foregroundColor(.white)
                                                .padding(8)
                                        }
                                        .cornerRadius(10)
                                        
                                        Text("Frequently Asked Questions")
                                            .foregroundColor(.black)
                                            .font(.system(size: 15))
                                            .padding(.trailing,70)// Padding around the HStack

                                    }
                                        .padding(.top, 5)
                                        .padding(.bottom, 10)
                                        .bold()// Padding around the HStack
                                )
                            
                            Spacer()
                                .frame(height: 100)
                        }
                    }
                    
                    
                    
                }
                .background(Color(hex: "F5F5F5"))
                .cornerRadius(20) // Apply corner radius to ScrollView
            }
            .padding(.top, 100)
            
        }
        .onAppear {
            viewModel.fetchData { _ in
                print("Recent Links Count: \(viewModel.recentLinks.count)")
                print("Top Links Count: \(viewModel.topLinks.count)")
            }
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

func getGreeting() -> String {
    let hour = Calendar.current.component(.hour, from: Date())

    if hour >= 6 && hour < 12 {
        return "Good Morning"
    } else if hour >= 12 && hour < 18 {
        return "Good Afternoon"
    } else if hour >= 18 && hour < 22 {
        return "Good Evening"
    } else {
        return "Good Night"
    }
}

