//
//  TabBarView.swift
//  CenterTabBar
//
//  Created by Satyadev Chauhan on 07/03/23.
//

import SwiftUI

enum Tab: String {
    
    case home = "Links"
    case search = "Cources"
    case message = "Campaigns"
    case user = "Profile"
    
    var image: String {
        switch self {
        case .home: return "Links"
        case .search: return "Cources"
        case .message: return "Campaigns"
        case .user: return "Profile"
        }
    }
}


struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let circleCenter = CGPoint(x: rect.midX, y: rect.midY)
        let circleRadius = min(rect.width, rect.height) / 2
        
        // Upper semicircle of the circle
        path.addArc(center: circleCenter, radius: circleRadius, startAngle: .degrees(10), endAngle: .degrees(90), clockwise: false)
        
        // Ellipse with curved edges
        let ellipseWidth = rect.width + 32
        let ellipseHeight = rect.height + 18// Adjust height as needed
        let ellipseRect = CGRect(x: rect.midX - ellipseWidth / 2, y: rect.minY - 5, width: ellipseWidth, height: ellipseHeight)
        let ellipsePath = UIBezierPath(ovalIn: ellipseRect)
        path.addPath(Path(ellipsePath.cgPath))
        
        return path
    }
}

struct TabBarView: View {
    
    @State var selected: Tab = .home
    @State var showMenu = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    
                    Spacer()
                    
                    switch selected {
                    case .home:
                        HomeView()
                    case .search:
                        Text(Tab.search.rawValue)
                    case .message:
                        Text(Tab.message.rawValue)
                    case .user:
                        Text(Tab.user.rawValue)
                    }
                    
                    Spacer()
                    
                    ZStack {
                        
                        if showMenu {
                            MenuView(widthAndHeight: geometry.size.width/7)
                                .offset(y: -geometry.size.height/6)
                        }
                        
                        HStack {
                            
                            TabBarItemView(selected: $selected, tab: .home, width: geometry.size.width/5, height: geometry.size.height/28)
                            
                            TabBarItemView(selected: $selected, tab: .search, width: geometry.size.width/5, height: geometry.size.height/28)
                            
                            ZStack {
                                
                                CustomShape()
                                    .fill(Color.white)
                                    .frame(width: geometry.size.width/7, height: geometry.size.width/7)
                                
                                Circle()
                                    .foregroundColor(.white)
                                    .frame(width: geometry.size.width/7, height: geometry.size.width/7)

                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width/7-6 , height: geometry.size.width/7-6)
                                    .foregroundColor(.accentColor)
                                    .rotationEffect(Angle(degrees: showMenu ? 135 : 0))
                                
                                
                                    
                            }
                            .offset(y: -geometry.size.height/8/2)
//                            .onTapGesture {
//                                withAnimation {
//                                    showMenu.toggle()
//                                }
//                            }
                            
                            TabBarItemView(selected: $selected, tab: .message, width: geometry.size.width/5, height: geometry.size.height/28)
                            
                            TabBarItemView(selected: $selected, tab: .user, width: geometry.size.width/5, height: geometry.size.height/28)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/8)
                        .background(Color("TabBarBackground").shadow(radius: 2))
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .onChange(of: selected) { _ in
                withAnimation {
                    showMenu = false
                }
            }
            .onAppear {
                showMenu = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
