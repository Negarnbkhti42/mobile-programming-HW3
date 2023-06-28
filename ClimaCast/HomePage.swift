import SwiftUI


struct HomeView: View {

    let favoriteUrls: [String] = [
        "london-city-of-london-greater-london-united-kingdom",
        "tehran-tehran-iran"
    ]

    let SortOptions = ["Name", "Temperature"]

    @State private var sortOption = "Name"

    @State private var favoriteLocations: [CurrentLocation] = [
        CurrentLocation(name: "London", temp_c: 10),
        CurrentLocation(name: "Tehran", temp_c: 20)
    ]

    func fetchWeather() async {
        do {
            let result = try await WeatherService().getCurrent(locations: favoriteUrls)
            print(result)
        } catch {
            print(error)
        }
    }

    var body: some View {
        NavigationView {
            VStack{
                Picker("Select a sorting option", selection: $sortOption) {
                    ForEach(sortOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)

                List {
                ForEach($favoriteLocations.sorted(by: {$sortOption == "Name" ? $0.name < $1.name : $0.temp_c < $1.temp_c}), id: \.self) 
                    { location in
                    NavigationLink(destination: Text(location.id)) {
                        CardView(location: location)
                    }
                }.onDelete { indexSet in
                    favoriteUrls.remove(atOffsets: indexSet)
                    favoriteLocations.remove(atOffsets: indexSet)
                }  
                }
                
                .navigationTitle("home")
                .toolbar {
                    Button {

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
