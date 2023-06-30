import Foundation

struct CurrentLocation: Decodable ,Identifiable {
    var location: LocationParams
    var current: CurrentParams 
    var id =  UUID()
    enum CodingKeys: String, CodingKey {
            case location , current
        }
    
}

struct LocationParams: Decodable {
    var name: String
}

struct CurrentParams: Decodable {
    var temp_c: Double
}

struct WeatherService {

    let baseUrl = "https://api.weatherapi.com/v1/"
    let key = "c582e3515da44ce1a90113153220803"

    func getCurrent(locations: [String]) async throws -> [CurrentLocation] {

        var result: [CurrentLocation] = []

        for location in locations {

            if let url = URL(string: "\(baseUrl)current.json?key=\(key)&q=\(location)") {
                    do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                        let decoded = try JSONDecoder().decode(CurrentLocation.self, from: data)
                    result.append(decoded)
                    } catch {
                        print(error)
                    }
                }
        }

            return result
    }

    func getSearchResult(location: String) async throws -> String {

    }
}
