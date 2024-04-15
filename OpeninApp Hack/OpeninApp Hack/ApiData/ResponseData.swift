import Foundation

struct ResponseData: Codable {
    let status: Bool
    let statusCode: Int
    let message: String
    let support_whatsapp_number: String
    let extra_income: Double
    let total_links: Int
    let total_clicks: Int
    let today_clicks: Int
    let top_source: String
    let top_location: String
    let startTime: String
    let links_created_today: Int
    let applied_campaign: Int
    let data: DataObject

    init(status: Bool,
         statusCode: Int,
         message: String,
         support_whatsapp_number: String,
         extra_income: Double,
         total_links: Int,
         total_clicks: Int,
         today_clicks: Int,
         top_source: String,
         top_location: String,
         startTime: String,
         links_created_today: Int,
         applied_campaign: Int,
         data: DataObject) {
        self.status = status
        self.statusCode = statusCode
        self.message = message
        self.support_whatsapp_number = support_whatsapp_number
        self.extra_income = extra_income
        self.total_links = total_links
        self.total_clicks = total_clicks
        self.today_clicks = today_clicks
        self.top_source = top_source
        self.top_location = top_location
        self.startTime = startTime
        self.links_created_today = links_created_today
        self.applied_campaign = applied_campaign
        self.data = data
    }
}

