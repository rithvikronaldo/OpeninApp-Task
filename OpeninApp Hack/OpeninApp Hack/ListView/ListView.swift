import SwiftUI
import URLImage

struct RecentLinksListView: View {
    let links: [Link]

    var body: some View {
        List(links, id: \.url_id) { link in
            LinkRow(link: link)
                .listRowSeparator(.hidden)
                .padding(.vertical, 15)
        }// Set the background color of the List
        .scaledToFit()
        .scrollContentBackground(.hidden)
    }
}

struct TopLinksListView: View {
    let links: [Link]

    var body: some View {
        List(links, id: \.url_id) { link in
            LinkRow(link: link)
                .listRowSeparator(.hidden)
                .padding(.vertical, 15)
        }
        .scaledToFit()
        .scrollContentBackground(.hidden)
    }
}

struct LinkRow: View {
    let link: Link
    
    @State private var formattedDate: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 20) {
                // Image
                if let imageURL = URL(string: link.original_image), !link.original_image.isEmpty {
                    URLImage(imageURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .cornerRadius(35)
                            .padding(.trailing, 10)
                            .padding(.bottom,10)
                    }
                }
                
                // Title, Date, Clicks
                VStack(alignment: .leading, spacing: 4) { // Adjust spacing here
                    Text(limitTitle(link.title))
                        .font(.system(size: 14))
                        .lineLimit(1) // Limit title to one line
                        .fixedSize(horizontal: false, vertical: true) // Allow title to truncate with ellipsis
                        .foregroundColor(.primary)
                       // Adjust text color
                    Text(formattedDate)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .padding(.bottom,15)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(link.total_clicks)")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .bold()
                        .padding(.trailing,5)
                    Text("Clicks")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom,20)
                }
            }
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .frame(minHeight: 80) // Set a fixed height for the row
        }
        .padding(.horizontal)
        .onAppear {
            formattedDate = formatDate(link.created_at)
        }
        .overlay(
            ZStack {
                Image("Rectangle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 10)
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                    .offset(y: 45)
                    .shadow(radius: 4)
                
                HStack{
                    Text(limitWebLink(link.web_link)) // Display the web link
                        .font(.system(size: 13))
                        .foregroundColor(.blue) // Adjust the color as needed
                        .padding(.horizontal)
                        .offset(x:-30 ,y: 43)
                    Image("Save")
                        .offset(x:30,y:43)
                }
                
            }
        )

    }
    
    private func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd MMM yyyy"
            return dateFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
    
    private func limitTitle(_ title: String) -> String {
        let threshold = 25
        return title.count > threshold ? "\(title.prefix(threshold))..." : title
    }
    private func limitWebLink(_ webLink: String) -> String {
        let threshold = 20 // Adjust the threshold as needed
        return webLink.count > threshold ? "\(webLink.prefix(threshold))..." : webLink
    }

}
