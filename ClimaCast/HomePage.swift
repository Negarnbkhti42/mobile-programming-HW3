import SwiftUI

struct HomeView: View {

    let favoriteLocations = [
        Location(id:"london-city-of-london-greater-london-united-kingdom", location: "London", temperature: "15")
        Location(id: "tehran-tehran-iran", location: "Tehran", temperature: "30")
    ]
    var body: some View {
        NavigationView {
            List(favoriteLocations) { location in
                NavigationLink(destination: Text(location.id)) {
                    CardView(location: location)
                }
            }
        }
        .navigationTitle("home")
        .toolbar {
            Button {

            } label: {
                Label("Add", systemImage: "plus")
            }
        }
    }
}
