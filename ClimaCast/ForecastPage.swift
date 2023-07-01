import SwiftUI

struct ForecastPage: View {
    var location  : String
    @State var foreCast : ForecastResponse? = nil
    //    @State var foreCast: ForecastResponse = ForecastResponse(
    //        location: LocationParams(
    //            name: "London",
    //            localtime: "2023-07-01"
    //        ),
    //        forecast: ForecastParams(
    //            forecastday: [
    //                Forecast(
    //                    date: "2023-07-01",
    //                    day: Day(
    //                        avgtemp_c: 10,
    //                        avgtemp_f: 50,
    //                        condition: conditionParams(
    //                            text: "Sunny",
    //                            icon: "https://cdn.weatherapi.com/weather/64x64/day/113.png"
    //                        )
    //                    )
    //                ),
    //                Forecast(
    //                    date: "2023-07-02",
    //                    day: Day(
    //                        avgtemp_c: 10,
    //                        avgtemp_f: 50,
    //                        condition: conditionParams(
    //                            text: "Sunny",
    //                            icon: "https://cdn.weatherapi.com/weather/64x64/day/113.png"
    //                        )
    //                    )
    //                ),
    //                Forecast(
    //                    date: "2023-07-03",
    //                    day: Day(
    //                        avgtemp_c: 10,
    //                        avgtemp_f: 50,
    //                        condition: conditionParams(
    //                            text: "Sunny",
    //                            icon: "https://cdn.weatherapi.com/weather/64x64/day/113.png"
    //                        )
    //                    )
    //                ),
    //            ]
    //        )
    //    )
    
    func fetchForecast() async {
        do {
            let result = try await WeatherService().getForecast(location: location)
            print(result)
            foreCast = result
        } catch {
            print(error)
        }
    }
    
    var body: some View {
//        NavigationView {
            
            Group {
                if foreCast != nil {
                
                
                    Text("\(foreCast!.location.name)")
                    Text("\(foreCast!.location.localtime)")
                    AsyncImage(url: URL(string: "\(foreCast!.forecast.forecastday[0].day.condition.icon[2...])")!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    Text("\(foreCast!.forecast.forecastday[0].day.condition.text)")
                    List(foreCast!.forecast.forecastday) { day in

                            HStack {
                                Text("\(day.date)")
                                Text("\(day.day.avgtemp_c)")

                                AsyncImage(url: URL(string: "\(day.day.condition.icon[2...])")!) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ProgressView()
                                }

                                Text("\(day.day.condition.text)")
                            }
                        
                    }
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Forecast")
                .task {
                    await fetchForecast()
                }
            
//        }
    }
}

struct ForecastPage_Previews: PreviewProvider {
    @State static var url=""
    static var previews: some View {
        ForecastPage(location:url)
    }
}
