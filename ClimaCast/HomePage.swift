import SwiftUI


struct HomeView: View {

    @State var favoriteUrls: [String] = [
        "london-city-of-london-greater-london-united-kingdom",
        "tehran-tehran-iran"
    ]

    let SortOptions = ["Name", "Temperature"]

    @State private var sortOption = "Name"

    @State private var favoriteLocations: [CurrentLocation] = [
        CurrentLocation(location: LocationParams(name: "London"), current: CurrentParams(temp_c: 30)),
        CurrentLocation(location: LocationParams(name: "Tehran"), current:  CurrentParams(temp_c: 20))
    ]

    

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
                    NavigationLink(destination: Text(location.location.name)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(.white)
                                .shadow(radius: 5)
                            
                            HStack {
                                Text(location.location.name)
                                Spacer()
                                Text("\(Double(round(1000 * location.current.temp_c) / 1000))")
                                Text("rainy")
                            }

                        }
                        .frame(width: .infinity, height: 100)
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

