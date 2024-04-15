import SwiftUI

struct DataView: View {
    let totalLinksItem: DataViewItem
    let todayClicksItem: DataViewItem
    let topSourceItem: DataViewItem
    let topLocationItem: DataViewItem

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                GridItemView(item: totalLinksItem, gridSize: CGSize(width: 110, height: 110))
                GridItemView(item: todayClicksItem, gridSize: CGSize(width: 110, height: 110))
                GridItemView(item: topSourceItem, gridSize: CGSize(width: 110, height: 110))
                GridItemView(item: topLocationItem, gridSize: CGSize(width: 110, height: 110))
            }
            .padding()
        }
    }
}

struct GridItemView: View {
    let item: DataViewItem
    let gridSize: CGSize // Size for the grid item

    var body: some View {
        VStack(alignment: .leading) {
            if let imageName = item.imageName {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30) // Increase size of the image
                    .padding(.leading, -5) // Add padding to the leading edge
                    .padding(.top, -15) // Add padding to the top edge
// Adjust top padding for spacing
            }
            Text(item.detail)
                .fontWeight(.bold)
                .font(.system(size: 18))
                .padding(.bottom, 2)
                .lineLimit(1)
            Text(item.title)
                .foregroundColor(Color.gray)
        }
        .frame(width: gridSize.width, height: gridSize.height) // Set fixed size for the grid item
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 0.5)
    }
}


struct DataViewItem: Identifiable {
    let id = UUID()
    let title: String
    let detail: String
    let imageName: String? // Optional image name or URL
}

