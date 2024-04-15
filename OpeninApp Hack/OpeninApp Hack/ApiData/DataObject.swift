import Foundation

struct DataObject: Codable {
    let recent_links: [Link]
    let top_links: [Link]
    let favourite_links: [Link]
    let overall_url_chart: [String: Int]?

    private enum CodingKeys: String, CodingKey {
        case recent_links
        case top_links
        case favourite_links
        case overall_url_chart
    }
}

