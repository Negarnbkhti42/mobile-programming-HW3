import Foundation

struct CurrentLocation: Decodable ,Identifiable {
    var location: LocationParams
    var current: CurrentParams 
   
    var id =  UUID()
    var url: String = ""
    enum CodingKeys: String, CodingKey {
            case location , current
        }
    
}

struct LocationParams: Decodable {
    var name: String
    var localtime: String
    
}

struct CurrentParams: Decodable {
    var temp_c: Double
    var temp_f: Double
    var wind_kph: Double
    var cloud: Double
    var condition: conditionParams
}

struct conditionParams: Decodable {
    var text: String
    var icon: String
}

struct ForecastResponse: Decodable {
    var location: LocationParams
    var forecast: ForecastParams
}

struct ForecastParams: Decodable {
    var forecastday: [Forecast]
}

struct Forecast: Decodable , Identifiable {
    var date: String
    var day: Day
    var id = UUID()
    enum CodingKeys: String, CodingKey {
        case date , day
            
        }
}

struct Day: Decodable {
    var avgtemp_c: Double
    var avgtemp_f: Double
    var condition: conditionParams
}

struct SearchLocation: Decodable {
    var url: String
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
                        var  decoded = try JSONDecoder().decode(CurrentLocation.self, from: data)
                        decoded.url = location
                    result.append(decoded)
                    } catch {
                        print(error)
                    }
                }
        }

            return result
    }

    func getSearchResult(searchValue: String) async throws -> String? {
        var a = "\(baseUrl)search.json?key=\(key)&q=\(searchValue)"
        print(a)
        if let url = URL(string: a) {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decode = try JSONDecoder().decode([SearchLocation].self, from: data)
                if decode.count > 0 {
                    return decode[0].url
                }
            } catch  {
                print(error)
            }
        }
        return nil;
    }

    func getForecast(location: String) async throws -> ForecastResponse? {
        if let url = URL(string: "\(baseUrl)forecast.json?key=\(key)&q=\(location)&days=3") {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decode = try JSONDecoder().decode(ForecastResponse.self, from: data)
                return decode
            } catch {
                print(error)
            }
        }
        return nil
    }
}

