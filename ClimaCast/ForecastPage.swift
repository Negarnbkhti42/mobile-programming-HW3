import SwiftUI


struct ForecastPage: View {
    @AppStorage("isCelsius") private var isCelcius = false
    var location  : String
    @State var foreCast : ForecastResponse? = nil
    
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
                    AsyncImage(url: URL(string: "https:\(foreCast!.forecast.forecastday[0].day.condition.icon)")!){image in
                            image.resizable()
                            .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                                }
                    Text("\(foreCast!.forecast.forecastday[0].day.condition.text)")
                    List(foreCast!.forecast.forecastday) { day in

                            HStack {
                                Text("\(day.date)")
                                Text("\(isCelcius ? day.day.avgtemp_c: day.day.avgtemp_f,specifier: "%.0f")")

                                AsyncImage(url: URL(string: "https:\(day.day.condition.icon)")!) {image in
                                    image.resizable()
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
