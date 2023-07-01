//
//  SearchPage.swift
//  ClimaCast
//
//  Created by Ainaz Rafiei on 7/1/23.
//

import SwiftUI

struct SearchPage: View {
    @Environment(\.presentationMode) var presentationMode

    @Binding var items: [String]
    @State var SearchVlue = "";
    @state var presentAlert = false;

    func search() async {
        do {
            let result = try await WeatherService().search(query: SearchVlue)
            print(result)
            if result != nil {
                items.append(result!)
                presentationMode.wrappedValue.dismiss()
            } else {
                presentAlert = true
            }
        } catch {
            print(error)
        }
    }

    var body: some View {
        NavigationView{
            Form{
                TextField("FavoriteLocation" ,text: $SearchVlue)
            }
            Button("Cancel" , role: .cancel){}

            .alert("no result found!", isPresented: $presentAlert){
                Button("OK", role: .cancel){}
            }
        }
        .navigationTitle(Text("Add new Favorite Location"))
        .toolbar{
            Button{
                await search()
            }label:{
                Text("Add")
            }
        }
    }
    
}

struct SearchPage_Previews: PreviewProvider {
    @State static var stringArr  : [String] = []
    static var previews: some View {
        SearchPage(items: $stringArr)
    }
}
