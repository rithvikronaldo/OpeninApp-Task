import Foundation
import Combine

class ContentViewModel: ObservableObject {
    static let shared = ContentViewModel() // Shared instance
    
    @Published var recentLinks: [Link] = []
    @Published var topLinks: [Link] = []
    @Published var favouriteLinks: [Link] = []
    @Published var overall_url_chart: [String: Int] = [:]
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    private init() {} // Private initializer to enforce singleton pattern

    func fetchData(completion: @escaping (ResponseData?) -> Void) {
        isLoading = true
        guard let url = URL(string: "https://api.inopenapp.com/api/v1/dashboardNew") else {
            errorMessage = "Invalid URL"
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "Failed to fetch data: \(error.localizedDescription)"
                    completion(nil)
                }
                return
            }
            

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "Invalid response"
                    completion(nil)
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "No data received"
                    completion(nil)
                }
                return
            }
            
//            print("Raw Data from API: \(String(data: data, encoding: .utf8) ?? "Failed to convert data to string")")


            do {
                let decodedResponse = try JSONDecoder().decode(ResponseData.self, from: data)
                print("Decoded Response Data: \(decodedResponse)")
                
                DispatchQueue.main.async {
                    self.recentLinks = decodedResponse.data.recent_links
                    self.topLinks = decodedResponse.data.top_links
                    self.favouriteLinks = decodedResponse.data.favourite_links
                    

                    if let overallURLChart = decodedResponse.data.overall_url_chart {
                        self.overall_url_chart = overallURLChart
                    } else {
                        let overallURLChartData: [String: Int] = [
                            "00:00": 0,
                            "01:00": 0,
                            "02:00": 0,
                            "03:00": 0,
                            "04:00": 0,
                            "05:00": 1,
                            "06:00": 0,
                            "07:00": 2,
                            "08:00": 4,
                            "09:00": 3,
                            "10:00": 2,
                            "11:00": 1,
                            "12:00": 2,
                            "13:00": 4,
                            "14:00": 3,
                            "15:00": 2,
                            "16:00": 0,
                            "17:00": 0,
                            "18:00": 4,
                            "19:00": 3,
                            "20:00": 0,
                            "21:00": 2,
                            "22:00": 1,
                            "23:00": 0,
                            "24:00": 0
                        ]
                        self.overall_url_chart = overallURLChartData
                    }
                    completion(decodedResponse)
                }
            } catch {
                print("Decoding error: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "Failed to decode data: \(error.localizedDescription)"
                    completion(nil)
                }
            }


        }.resume()
    }

}

