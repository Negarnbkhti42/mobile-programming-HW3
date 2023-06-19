import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack{

            .navigationTitle("home")
            .toolbar {
                Button {
                    print("Edit button was tapped")
                    } label: { 
                        Image(systemName: "plus")
                    }
                
                
            }
        }
    }
}