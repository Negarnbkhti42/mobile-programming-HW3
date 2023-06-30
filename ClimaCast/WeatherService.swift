import Foundation

struct CurrentLocation: Decodable {
    let name: String
    let temp_c: Double
}

struct WeatherService {

    let baseUrl = "https://api.weatherapi.com/v1/"
    let key = "c582e3515da44ce1a90113153220803"

    func getCurrent(locations: [String]) async throws -> [CurrentLocation] {

        let result: [CurrentLocation] = []

        for location in locations {

            URLSession.shared.dataTask(with: URL(string: "\(baseUrl)current.json?key=\(key)&q=\(location)")!) { data, response, error in
                
                if let error = error {
                    print(error)
                    return
                }

                if let data = data {
                    do {
                        let decoded = try JSONDecoder().decode(CurrentLocation.self, from: data)
                        result.append(CurrentLocation(name: decoded.name, temp_c: "\(decoded.temp_c)"))
                    } catch {
                        print(error)
                    }
                }
            }.resume()

        }
            return result
    }
}
