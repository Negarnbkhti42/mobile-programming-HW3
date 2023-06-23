struct CurrentLocation: Decodable {
    let name: String
    let temp_c: Double
}

struct WeatherService {

    let baseUrl = "https://api.weatherapi.com/v1/"
    let key = "c582e3515da44ce1a90113153220803"

    func getCurrent(locations: [String]) async throws -> [LocationItem] {

        let result: [LocationItem] = []

        for location in locations {

            guard let url = URL(string: "\(baseUrl)current.json?key=\(key)&q=\(location)") else {
                print("wrong url")
                
            }

            guard let (data, response) = try? await URLSession.shared.data(from: url) else{
                print("no response")
            }   

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                print("response not ok")
            }

            guard let result = try? JSONDecoder().decode(CurrentLocation.self, from: data) else {
                print("response not decoded")
            }

            return result
        }
    }
}