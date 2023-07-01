import SwiftUI


struct HomeView: View {
    @AppStorage("isCelsius") private var isCelcius = false
    @State var favoriteUrls: [String] = [
        "london-city-of-london-greater-london-united-kingdom",
        "tehran-tehran-iran"
    ]

    let SortOptions = ["Name", "Temperature"]

    @State private var sortOption = "Name"

    @State private var favoriteLocations: [CurrentLocation] = []

    

    func fetchWeather() async {
        do {
            let result = try await WeatherService().getCurrent(locations: favoriteUrls)
            print(result)
            favoriteLocations.removeAll()

            for location in result {
                favoriteLocations.append(location)
            }
        } catch {
            print(error)
        }
    }
   

    var body: some View {
        NavigationView {
            VStack{
                Picker("Select a sorting option", selection: $sortOption) {
                    ForEach(SortOptions , id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)

                List {
                    ForEach(favoriteLocations.sorted(by: {sortOption == "Name" ? $0.location.name < $1.location.name : $0.current.temp_c < $1.current.temp_c}), id: \.id)
                    { location in
                        NavigationLink(destination: ForecastPage(location: location.url))
                        {
                            HStack {
                                Text(location.location.name)
                                Spacer()
                                Text("\(Double(round(1000 * (isCelcius ? location.current.temp_c: location.current.temp_f)) / 1000))")
                            }

                    }
                }.onDelete { indexSet in
                    favoriteUrls.remove(atOffsets: indexSet)
                    favoriteLocations.remove(atOffsets: indexSet)
                }
                }
                
                .navigationTitle("home")
                .toolbar {
                    NavigationLink{
                           SearchPage(items: $favoriteUrls)
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
                .task {
                    await fetchWeather()
                }
            }
        }
   
    }
}

