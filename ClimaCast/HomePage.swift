import SwiftUI


struct HomeView: View {

    let favoriteUrls: [String] = [
        "london-city-of-london-greater-london-united-kingdom",
        "tehran-tehran-iran"
    ]

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
            List {
                ForEach($favoriteLocations, id: \.self) { location in
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
